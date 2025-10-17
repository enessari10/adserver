import { useEffect, useMemo, useState } from 'react'
import api from '../services/api.js'

export default function Reports() {
  const [from, setFrom] = useState('')
  const [to, setTo] = useState('')
  const [groupBy, setGroupBy] = useState('day')
  const [data, setData] = useState({ impressions: [], clicks: [] })
  const [mode, setMode] = useState('time') // time | campaigns | ads
  const [loading, setLoading] = useState(false)

  async function run() {
    setLoading(true)
    const endpoint = mode === 'campaigns' ? '/stats/report/campaigns' : mode === 'ads' ? '/stats/report/ads' : '/stats/report'
    const res = await api.get(endpoint, { params: { from, to, groupBy } })
    setData(res.data)
    setLoading(false)
  }

  useEffect(() => { run() }, [])

  const rows = useMemo(() => {
    const map = new Map()
    for (const r of data.impressions) {
      const key = `${r.ts}|${r.campaign_id || ''}|${r.ad_id || ''}`
      map.set(key, { ts: r.ts, campaign_id: r.campaign_id, ad_id: r.ad_id, impressions: Number(r.impressions) || 0, clicks: 0 })
    }
    for (const r of data.clicks) {
      const key = `${r.ts}|${r.campaign_id || ''}|${r.ad_id || ''}`
      const row = map.get(key) || { ts: r.ts, campaign_id: r.campaign_id, ad_id: r.ad_id, impressions: 0, clicks: 0 }
      row.clicks += Number(r.clicks) || 0
      map.set(key, row)
    }
    return Array.from(map.values()).sort((a,b)=>a.ts.localeCompare(b.ts))
  }, [data])

  return (
    <div className="space-y-6">
      <EmbedGenerator />
      <div className="card">
        <div className="card-header">Filtreler</div>
        <div className="card-body grid grid-cols-1 md:grid-cols-5 gap-3">
          <select className="border rounded px-3 py-2" value={mode} onChange={e=>setMode(e.target.value)}>
            <option value="time">Zamana Göre</option>
            <option value="campaigns">Kampanya Bazlı</option>
            <option value="ads">Reklam Bazlı</option>
          </select>
          <input type="date" className="border rounded px-3 py-2" value={from} onChange={e=>setFrom(e.target.value)} />
          <input type="date" className="border rounded px-3 py-2" value={to} onChange={e=>setTo(e.target.value)} />
          <select className="border rounded px-3 py-2" value={groupBy} onChange={e=>setGroupBy(e.target.value)}>
            <option value="hour">Saat</option>
            <option value="day">Gün</option>
          </select>
          <button className="bg-brand-500 text-white rounded px-4" onClick={run}>Raporu Çalıştır</button>
        </div>
      </div>

      <div className="card">
        <div className="card-header">Rapor</div>
        <div className="card-body overflow-auto">
          {loading ? 'Loading...' : (
            <table className="w-full text-sm">
              <thead>
                <tr className="text-left text-gray-500">
                  <th className="py-2">{mode==='time'?'Zaman': mode==='campaigns'?'Kampanya':'Reklam'}</th>
                  {mode!=='campaigns' && <th>Kampanya</th>}
                  {mode!=='ads' && <th>Reklam</th>}
                  {mode==='ads' && <th>Platform</th>}
                  <th>Gösterim</th>
                  <th>Tıklama</th>
                  <th>TO</th>
                </tr>
              </thead>
              <tbody>
                {rows.map((r, i) => {
                  const firstCol = mode==='time' ? r.ts : mode==='campaigns' ? (r.campaign_name || r.campaign_id) : (r.ad_title || r.ad_id)
                  return (
                    <tr key={i} className="border-t">
                      <td className="py-2">{firstCol}</td>
                      {mode!=='campaigns' && <td>{r.campaign_name || r.campaign_id || '-'}</td>}
                      {mode!=='ads' && <td>{r.ad_title || r.ad_id || '-'}</td>}
                      {mode==='ads' && <td>{r.platform || '-'}</td>}
                      <td>{r.impressions}</td>
                      <td>{r.clicks}</td>
                      <td>{r.impressions ? ((r.clicks / r.impressions) * 100).toFixed(2) : '0.00'}%</td>
                    </tr>
                  )
                })}
              </tbody>
            </table>
          )}
        </div>
      </div>
    </div>
  )
}

function EmbedGenerator(){
  const [campaignId, setCampaignId] = useState('')
  const [adId, setAdId] = useState('')
  const [campaigns, setCampaigns] = useState([])
  const [ads, setAds] = useState([])
  const [width, setWidth] = useState(600)
  const [height, setHeight] = useState(200)
  const [lazy, setLazy] = useState(true)

  useEffect(() => {
    async function load(){
      const [c, a] = await Promise.all([api.get('/campaigns'), api.get('/ads')])
      setCampaigns(c.data)
      setAds(a.data)
    }
    load()
  }, [])
  const origin = window.location.origin
  const selectedAd = ads.find(a => String(a.id) === String(adId))
  const imgUrl = selectedAd?.image_url || ''
  const targetUrl = selectedAd?.target_url || ''
  const script = selectedAd ? `
<div data-ad-id="${adId}" data-campaign-id="${campaignId}" data-target-url="${targetUrl}">
  ${imgUrl ? `<a href="${targetUrl}" target="_blank" rel="noopener noreferrer"><img src="${imgUrl}" alt="Reklam" width="${width}" height="${height}" ${lazy ? 'loading=\"lazy\"' : ''}/></a>` : '<!-- Görseli kendiniz ekleyin; container tıklamalarını sayacağız -->'}
</div>
<script>
  window.AD_SERVER_BASE = '${origin}';
</` + `script>
<script src="${origin}/adtag.js"></` + `script>` : ''

  return (
    <div className="card">
      <div className="card-header">Embed Kod Oluşturucu</div>
      <div className="card-body space-y-3">
        <div className="grid grid-cols-1 md:grid-cols-5 gap-3">
          <select className="border rounded px-3 py-2" value={campaignId} onChange={e=>{ setCampaignId(e.target.value); setAdId(''); }}>
            <option value="">Kampanya seç</option>
            {campaigns.map(c => <option key={c.id} value={c.id}>{c.name}</option>)}
          </select>
          <select className="border rounded px-3 py-2" value={adId} onChange={e=>setAdId(e.target.value)}>
            <option value="">Reklam seç</option>
            {(campaignId ? ads.filter(a => String(a.campaign_id) === String(campaignId)) : ads)
              .map(a => <option key={a.id} value={a.id}>{a.title || `Reklam #${a.id}`}</option>)}
          </select>
          <input className="border rounded px-3 py-2" type="number" min="1" placeholder="Genişlik" value={width} onChange={e=>setWidth(Number(e.target.value) || 0)} />
          <input className="border rounded px-3 py-2" type="number" min="1" placeholder="Yükseklik" value={height} onChange={e=>setHeight(Number(e.target.value) || 0)} />
          <label className="inline-flex items-center gap-2 text-sm text-gray-700"><input type="checkbox" checked={lazy} onChange={e=>setLazy(e.target.checked)} /> Lazy load</label>
        </div>
        <div className="flex items-center justify-between mt-3">
          <div className="text-sm text-gray-500">{!selectedAd ? 'Lütfen kampanya ve reklam seçin' : ''}</div>
          <button className="bg-brand-500 text-white rounded px-4 disabled:opacity-50" disabled={!script} onClick={()=>navigator.clipboard.writeText(script)}>Kodu Kopyala</button>
        </div>
        <textarea className="w-full h-48 border rounded p-3 font-mono text-xs" readOnly value={script} placeholder="Önce kampanya ve reklam seçin" />
      </div>
    </div>
  )
}


