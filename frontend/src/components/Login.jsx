import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import api from '../services/api.js'

export default function Login(){
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)
  const navigate = useNavigate()

  async function submit(e){
    e.preventDefault()
    setError('')
    setLoading(true)
    try {
      const res = await api.post('/auth/login', { email, password })
      localStorage.setItem('token', res.data.token)
      localStorage.setItem('user', JSON.stringify(res.data.user || {}))
      navigate('/')
      // refresh to update header state quickly
      setTimeout(()=>window.location.replace('/'), 50)
    } catch (err) {
      setError(err?.response?.data?.message || 'Login failed')
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="min-h-[60vh] flex items-center justify-center">
      <form onSubmit={submit} className="card w-full max-w-md">
        <div className="card-header">Login</div>
        <div className="card-body space-y-3">
          {error && <div className="text-red-600 text-sm">{error}</div>}
          <div>
            <label className="block text-sm text-gray-600 mb-1">Email</label>
            <input className="border rounded w-full px-3 py-2" type="email" value={email} onChange={e=>setEmail(e.target.value)} placeholder="you@example.com" required />
          </div>
          <div>
            <label className="block text-sm text-gray-600 mb-1">Password</label>
            <input className="border rounded w-full px-3 py-2" type="password" value={password} onChange={e=>setPassword(e.target.value)} placeholder="••••••••" required />
          </div>
          <button className="bg-brand-600 text-white rounded px-4 py-2 w-full" disabled={loading}>
            {loading ? 'Signing in...' : 'Sign In'}
          </button>
        </div>
      </form>
    </div>
  )
}


