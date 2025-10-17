import { useEffect, useState } from 'react'
import { AreaChart, Area, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Legend } from 'recharts'
import api from '../services/api.js'

export default function Dashboard() {
  const [chartData, setChartData] = useState([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function fetchData() {
      try {
        const res = await api.get('/stats/report', { params: { groupBy: 'day' } })
        const byTs = new Map()
        for (const r of res.data.impressions) {
          const key = r.ts
          if (!byTs.has(key)) byTs.set(key, { ts: key, impressions: 0, clicks: 0 })
          byTs.get(key).impressions += Number(r.impressions)
        }
        for (const r of res.data.clicks) {
          const key = r.ts
          if (!byTs.has(key)) byTs.set(key, { ts: key, impressions: 0, clicks: 0 })
          byTs.get(key).clicks += Number(r.clicks)
        }
        setChartData(Array.from(byTs.values()).sort((a,b)=>a.ts.localeCompare(b.ts)))
      } finally {
        setLoading(false)
      }
    }
    fetchData()
  }, [])

  return (
    <div className="space-y-6">
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <StatCard title="Gösterim" value={sum(chartData, 'impressions')} />
        <StatCard title="Tıklama" value={sum(chartData, 'clicks')} />
        <StatCard title="TO (CTR)" value={`${pct(sum(chartData,'clicks'), sum(chartData,'impressions'))}%`} />
      </div>

      <div className="card">
        <div className="card-header">Zamana Göre Performans</div>
        <div className="card-body" style={{height: 360}}>
          {loading ? (
            <div className="text-gray-500">Loading...</div>
          ) : (
            <ResponsiveContainer width="100%" height="100%">
              <AreaChart data={chartData} margin={{ top: 10, right: 20, left: 0, bottom: 0 }}>
                <defs>
                  <linearGradient id="imp" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="5%" stopColor="#6366f1" stopOpacity={0.8}/>
                    <stop offset="95%" stopColor="#6366f1" stopOpacity={0}/>
                  </linearGradient>
                  <linearGradient id="clk" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="5%" stopColor="#10b981" stopOpacity={0.8}/>
                    <stop offset="95%" stopColor="#10b981" stopOpacity={0}/>
                  </linearGradient>
                </defs>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="ts" />
                <YAxis allowDecimals={false} />
                <Tooltip />
                <Legend />
                <Area type="monotone" dataKey="impressions" stroke="#6366f1" fillOpacity={1} fill="url(#imp)" />
                <Area type="monotone" dataKey="clicks" stroke="#10b981" fillOpacity={1} fill="url(#clk)" />
              </AreaChart>
            </ResponsiveContainer>
          )}
        </div>
      </div>

      <div className="card">
        <div className="card-header">Özet Tablo</div>
        <div className="card-body overflow-auto">
          <table className="w-full text-sm">
            <thead>
              <tr className="text-left text-gray-500">
                <th className="py-2">Tarih</th>
                <th>Gösterim</th>
                <th>Tıklama</th>
                <th>TO</th>
              </tr>
            </thead>
            <tbody>
              {chartData.map(r => (
                <tr key={r.ts} className="border-t">
                  <td className="py-2">{r.ts}</td>
                  <td>{r.impressions}</td>
                  <td>{r.clicks}</td>
                  <td>{pct(r.clicks, r.impressions)}%</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  )
}

function StatCard({ title, value }) {
  return (
    <div className="card">
      <div className="card-body">
        <div className="text-sm text-gray-500">{title}</div>
        <div className="text-2xl font-semibold mt-1">{value}</div>
      </div>
    </div>
  )
}

function sum(rows, key) {
  return rows.reduce((acc, r) => acc + Number(r[key] || 0), 0)
}

function pct(a, b) {
  if (!b) return 0
  return ((a / b) * 100).toFixed(2)
}


