import { Routes, Route, BrowserRouter, Navigate } from 'react-router-dom'
//* Configuraciones
import { Moneda, Monedas } from '../views/configuraciones/monedas'

// * Auth
import { Login } from '../views/auth'
//* Error
import { _404 } from '../views/Error'
//* Components
import { ProtectedRoute } from '../components/ProtectedRoute'
//* Layouts
import { AuthLayout } from '../layouts'

//* Recovery password
import { RecoveryPassword } from '../views/recovery_pass'

const Router = () => {
  return (
    <BrowserRouter>
      <Routes>
        <Route path='/' element={<Navigate to='/login' />} />
        <Route path='/login' element={<Login />} />
        <Route path='/recovery' element={<RecoveryPassword />} />
        <Route element={<ProtectedRoute />}>
          <Route element={<AuthLayout />}>
            <Route path='/dashboard' element={<h1>Dashboard</h1>} />
            <Route path='/configuraciones'>
              <Route path='monedas'>
                <Route path='' element={<Monedas />} />
                <Route path=':id/edit' element={<Moneda />} />
                <Route path=':id/watch' element={<Moneda watch />} />
              </Route>
              <Route path='*' element={<_404 to={-1} />} />
            </Route>
          </Route>
        </Route>
        <Route path='*' element={<_404 />} />
      </Routes>
    </BrowserRouter>
  )
}

export default Router
