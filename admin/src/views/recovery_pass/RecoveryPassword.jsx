import { memo } from 'react'
import logo from '../../assets/images/logo/Logo_Oficial_ZEIVOR_horizontal_principal.svg'
import { Link } from 'react-router-dom'
import { useField } from '../../hooks/useField'
import { useFetch } from '../../hooks/useFetch'
const RecoveryPassword = () => {
  const correo = useField({ type: 'text', state: '' })
  const handleSubmit = (event) => {
    event.preventDefault()
  }

  return (
    <div className="container-scroller">
      <div className="container-fluid page-body-wrapper full-page-wrapper">
        <div className="content-wrapper d-flex align-items-center auth px-0">
          <div className="row w-100 mx-0">
            <div className="col-lg-4 mx-auto">
              <div className="text-left py-5 px-4 px-sm-5">
                <div className="brand-logo" style={{
                  textAlign: 'center'
                }}>
                  <a href="{{ route('home') }}" target="_top" alt="IUSFORM Sistema para Abogados"
                    title="IUSFORM Sistema para Abogados"><img
                      src={logo}
                      style={{
                        textAlign: 'center',
                        width: '200px'
                      }}
                    /></a>
                </div>
                <h4 style={{
                  textAlign: 'center'
                }}>Recuperar Contraseña</h4>
                <h6 className="font-weight-light" style={{
                  textAlign: 'center'
                }}>Por favor, ingresa tu
                  correo electrónico para recibir las instrucciones.</h6>

                <form onSubmit={handleSubmit}>
                  <div className="form-group">
                    <input type="text" className="form-control form-control-lg"
                      {...correo}
                      placeholder="Correo Electrónico" required

                    />
                  </div>

                  <div className="mt-3">
                    <button type="submit"
                      className="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn">
                      Enviar
                    </button>
                  </div>

                  <div className="mt-3">

                    <Link to="/login" className="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn">
                      Regresar al Login
                    </Link>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

export default memo(RecoveryPassword)
