import React from 'react'
import { NavLink, Route, Routes, useNavigate } from 'react-router-dom'
import Dashboard from './components/Dashboard.jsx'
import Campaigns from './components/Campaigns.jsx'
import Ads from './components/Ads.jsx'
import Reports from './components/Reports.jsx'
import Login from './components/Login.jsx'
import Profile from './components/Profile.jsx'

export default function App() {
  return (
    <div className="min-h-screen bg-gray-50">
      <Header />
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
        <Routes>
          <Route path="/login" element={<Login />} />
          <Route path="/" element={<RequireAuth><Dashboard /></RequireAuth>} />
          <Route path="/campaigns" element={<RequireAuth><Campaigns /></RequireAuth>} />
          <Route path="/ads" element={<RequireAuth><Ads /></RequireAuth>} />
          <Route path="/reports" element={<RequireAuth><Reports /></RequireAuth>} />
          <Route path="/profile" element={<RequireAuth><Profile /></RequireAuth>} />
        </Routes>
      </div>
    </div>
  )
}

function Header() {
  const navLink = ({ isActive }) =>
    `px-3 py-2 rounded-md text-sm font-medium ${isActive ? 'bg-brand-600 text-white' : 'text-gray-700 hover:bg-gray-100'}`
  return (
    <header className="bg-white border-b">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-16 flex items-center justify-between">
        <div className="flex items-center gap-3">
          <div className="w-8 h-8 rounded bg-brand-500" />
          <span className="font-semibold">Reklam Sunucu</span>
        </div>
        <nav className="flex items-center gap-2">
          <NavLink to="/" className={navLink} end>Gösterge Paneli</NavLink>
          <NavLink to="/campaigns" className={navLink}>Kampanyalar</NavLink>
          <NavLink to="/ads" className={navLink}>Reklamlar</NavLink>
          <NavLink to="/reports" className={navLink}>Raporlar</NavLink>
        </nav>
      </div>
    </header>
  )
}

function RequireAuth({ children }){
  const token = typeof window !== 'undefined' ? localStorage.getItem('token') : null
  if (!token) {
    window.location.replace('/login')
    return null
  }
  return children
}


