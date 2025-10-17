import { useEffect, useState } from 'react'
import api from '../services/api.js'

export default function Profile(){
  const [user, setUser] = useState(null)
  const [name, setName] = useState('')
  const [password, setPassword] = useState('')
  const [saving, setSaving] = useState(false)
  const [message, setMessage] = useState('')

  useEffect(() => {
    async function load(){
      const res = await api.get('/auth/me')
      setUser(res.data)
      setName(res.data.name || '')
    }
    load()
  }, [])

  async function save(e){
    e.preventDefault()
    setSaving(true)
    setMessage('')
    await api.put('/auth/me', { name, password: password || undefined })
    setMessage('Saved')
    setSaving(false)
    setPassword('')
  }

  if (!user) return <div>Loading...</div>

  return (
    <div className="space-y-6">
      <div className="card">
        <div className="card-header">Profile</div>
        <div className="card-body space-y-3">
          {message && <div className="text-green-600 text-sm">{message}</div>}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
            <div>
              <label className="block text-sm text-gray-600 mb-1">Email</label>
              <input className="border rounded w-full px-3 py-2 bg-gray-100" value={user.email} disabled />
            </div>
            <div>
              <label className="block text-sm text-gray-600 mb-1">Name</label>
              <input className="border rounded w-full px-3 py-2" value={name} onChange={e=>setName(e.target.value)} />
            </div>
            <div>
              <label className="block text-sm text-gray-600 mb-1">New Password</label>
              <input className="border rounded w-full px-3 py-2" type="password" value={password} onChange={e=>setPassword(e.target.value)} placeholder="Leave blank to keep" />
            </div>
          </div>
          <button className="bg-brand-600 text-white rounded px-4 py-2" onClick={save} disabled={saving}>
            {saving ? 'Saving...' : 'Save Changes'}
          </button>
        </div>
      </div>
    </div>
  )
}


