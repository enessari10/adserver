import { useEffect, useState } from 'react'
import api from '../services/api.js'

export default function Campaigns() {
  const [items, setItems] = useState([])
  const [loading, setLoading] = useState(true)
  const [form, setForm] = useState({ name: '', budget: 0, status: 'active' })

  async function load() {
    setLoading(true)
    const res = await api.get('/campaigns')
    setItems(res.data)
    setLoading(false)
  }
  useEffect(() => { load() }, [])

  async function create(e) {
    e.preventDefault()
    await api.post('/campaigns', form)
    setForm({ name: '', budget: 0, status: 'active' })
    load()
  }

  return (
    <div className="space-y-6">
      <div className="card">
        <div className="card-header">Kampanya Oluştur</div>
        <div className="card-body">
          <form onSubmit={create} className="grid grid-cols-1 md:grid-cols-4 gap-3">
            <input className="border rounded px-3 py-2" placeholder="Ad" value={form.name} onChange={e=>setForm({...form, name:e.target.value})} />
            <input className="border rounded px-3 py-2" type="number" placeholder="Bütçe" value={form.budget} onChange={e=>setForm({...form, budget:Number(e.target.value)})} />
            <select className="border rounded px-3 py-2" value={form.status} onChange={e=>setForm({...form, status:e.target.value})}>
              <option value="active">aktif</option>
              <option value="paused">duraklatıldı</option>
              <option value="archived">arşivlendi</option>
            </select>
            <button className="bg-brand-500 text-white rounded px-4">Oluştur</button>
          </form>
        </div>
      </div>

      <div className="card">
        <div className="card-header">Kampanyalar</div>
        <div className="card-body">
          {loading ? 'Loading...' : (
            <table className="w-full text-sm">
              <thead>
                <tr className="text-left text-gray-500">
                  <th className="py-2">ID</th>
                  <th>Ad</th>
                  <th>Bütçe</th>
                  <th>Durum</th>
                </tr>
              </thead>
              <tbody>
                {items.map(c => (
                  <tr key={c.id} className="border-t">
                    <td className="py-2">{c.id}</td>
                    <td>{c.name}</td>
                    <td>₺{Number(c.budget).toFixed(2)}</td>
                    <td><span className="px-2 py-1 rounded bg-gray-100">{c.status}</span></td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </div>
      </div>
    </div>
  )
}


