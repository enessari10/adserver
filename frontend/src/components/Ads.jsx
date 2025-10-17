import { useEffect, useMemo, useState } from 'react'
import api from '../services/api.js'

export default function Ads() {
  const [ads, setAds] = useState([])
  const [campaigns, setCampaigns] = useState([])
  const [form, setForm] = useState({ campaign_id: '', title: '', image_url: '', target_url: '', status: 'active', platform: '' })
  const [editing, setEditing] = useState(null)

  async function load() {
    const [a, c] = await Promise.all([
      api.get('/ads'),
      api.get('/campaigns')
    ])
    setAds(a.data)
    setCampaigns(c.data)
  }
  useEffect(() => { load() }, [])

  async function create(e) {
    e.preventDefault()
    if (editing) {
      await api.put(`/ads/${editing}`, { ...form, campaign_id: Number(form.campaign_id) || null })
    } else {
      await api.post('/ads', { ...form, campaign_id: Number(form.campaign_id) || null })
    }
    setForm({ campaign_id: '', title: '', image_url: '', target_url: '', status: 'active', platform: '' })
    setEditing(null)
    load()
  }

  async function onEdit(ad){
    setEditing(ad.id)
    setForm({
      campaign_id: ad.campaign_id || '',
      title: ad.title || '',
      image_url: ad.image_url || '',
      target_url: ad.target_url || '',
      status: ad.status || 'active',
      platform: ad.platform || ''
    })
    window.scrollTo({ top: 0, behavior: 'smooth' })
  }

  async function onDelete(ad){
    if (!confirm('Silmek istediğinize emin misiniz?')) return
    await api.delete(`/ads/${ad.id}`)
    load()
  }

  return (
    <div className="space-y-6">
      <div className="card">
        <div className="card-header">{editing ? 'Reklamı Güncelle' : 'Reklam Oluştur'}</div>
        <div className="card-body">
          <form onSubmit={create} className="grid grid-cols-1 md:grid-cols-6 gap-3">
            <select className="border rounded px-3 py-2" value={form.campaign_id} onChange={e=>setForm({...form, campaign_id:e.target.value})}>
              <option value="">Kampanya seç</option>
              {campaigns.map(c => <option key={c.id} value={c.id}>{c.name}</option>)}
            </select>
            <input className="border rounded px-3 py-2" placeholder="Başlık" value={form.title} onChange={e=>setForm({...form, title:e.target.value})} />
            <input className="border rounded px-3 py-2" placeholder="Görsel URL" value={form.image_url} onChange={e=>setForm({...form, image_url:e.target.value})} />
            <input className="border rounded px-3 py-2" placeholder="Hedef URL" value={form.target_url} onChange={e=>setForm({...form, target_url:e.target.value})} />
            <input className="border rounded px-3 py-2" placeholder="Platform (örn. Instagram)" value={form.platform} onChange={e=>setForm({...form, platform:e.target.value})} />
            <select className="border rounded px-3 py-2" value={form.status} onChange={e=>setForm({...form, status:e.target.value})}>
              <option value="active">aktif</option>
              <option value="paused">duraklatıldı</option>
              <option value="archived">arşivlendi</option>
            </select>
            <button className="bg-brand-500 text-white rounded px-4">{editing ? 'Güncelle' : 'Oluştur'}</button>
            {editing && <button type="button" className="border rounded px-4" onClick={()=>{ setEditing(null); setForm({ campaign_id: '', title: '', image_url: '', target_url: '', status: 'active', platform: '' }) }}>İptal</button>}
          </form>
        </div>
      </div>

      <div className="card">
        <div className="card-header">Reklamlar</div>
        <div className="card-body grid grid-cols-1 md:grid-cols-3 gap-4">
          {ads.map(ad => (
            <div key={ad.id} className="border rounded overflow-hidden bg-white">
              {ad.image_url ? (
                <img src={ad.image_url} alt={ad.title} className="w-full h-40 object-cover" />
              ) : (
                <div className="w-full h-40 bg-gray-100 flex items-center justify-center text-gray-400">Görsel yok</div>
              )}
              <div className="p-3 space-y-2">
                <div className="font-semibold">{ad.title || 'Başlıksız'}</div>
                <div className="text-xs text-gray-500">ID: {ad.id}</div>
                <div className="text-xs text-gray-500 break-all">Hedef: {ad.target_url || '-'}</div>
                <div className="flex items-center gap-2">
                  <span className="text-xs px-2 py-1 rounded bg-gray-100">{ad.status}</span>
                  {ad.platform && <span className="text-xs px-2 py-1 rounded bg-brand-50 text-brand-700 border border-brand-100">{ad.platform}</span>}
                </div>
                <div className="flex gap-2 pt-1">
                  <button className="text-xs px-3 py-1 rounded bg-gray-100" onClick={()=>onEdit(ad)}>Düzenle</button>
                  <button className="text-xs px-3 py-1 rounded bg-red-100 text-red-700" onClick={()=>onDelete(ad)}>Sil</button>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  )
}


