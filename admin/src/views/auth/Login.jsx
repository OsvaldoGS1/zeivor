import { memo, useContext } from "react";
import { Link, Navigate, useNavigate } from "react-router-dom";
import { useLocalStorage } from "../../hooks/useLocalStorage";
import { useMutation } from "@tanstack/react-query";
// import background from '../../assets/images/backgrounds/background_login_1920x1080_2.jpg'
import logo from "../../assets/images/logo/Logo_Oficial_ZEIVOR_horizontal_principal.svg";
import { useField } from "../../hooks/useField";
import { login as signin } from "../../api/auth";
import { UsuarioContext } from "../../context/UsuarioContext";
import Swal from "sweetalert2";
import "./auth.css";

const Login = () => {
  const navigate = useNavigate();
  const usuario = useField({ type: "text", state: "" });
  const password = useField({ type: "password", state: "" });
  const [, setUsuarioLS] = useLocalStorage("usuario", null);
  const [usuarioContext, setUsuarioContext] = useContext(UsuarioContext);
  if (usuarioContext) return <Navigate to="/dashboard" />;

  const login = useMutation({
    mutationFn: signin,
    onSuccess: (data) => {
      console.log(data);
      if (data?.token) {
        setUsuarioLS(data);
        setUsuarioContext(data);
        navigate("/dashboard");
      }
    },
    onError: (error) => {
      console.log(error?.response?.data?.error);
      Swal.fire({
        icon: "error",
        title: "Oops...",
        text: "Usuario o contraseña incorrectos",
      });
    },
  });

  const handleSubmit = (event) => {
    event.preventDefault();
    const user = {
      usuario: usuario.value,
      password: password.value,
    };

    login.mutate(user);
  };

  return (
    <div className="container-scroller">
      <div className="container-fluid page-body-wrapper full-page-wrapper">
        <div className="content-wrapper d-flex align-items-center auth px-0 background">
          <div className="row w-100 mx-0">
            <div className="col-lg-4 mx-auto">
              <div className="text-left py-5 px-4 px-sm-5">
                <div className="brand-logo" style={{ textAlign: "center" }}>
                  <a
                    href="{{ route('home') }}"
                    target="_top"
                    alt="Zeibor Sistema para Abogados"
                    title="Zeibor Sistema para Abogados"
                  >
                    <img
                      src={logo}
                      alt="Zeivor Sistema para Abogados"
                      style={{ textAlign: "center", width: "200px" }}
                    />
                  </a>
                </div>
                <h4 style={{ textAlign: "center" }}>¡Bienvenido!</h4>
                <h6
                  className="font-weight-light"
                  style={{ textAlign: "center" }}
                >
                  Por favor inicia sesión para continuar.
                </h6>

                <form method="POST" onSubmit={handleSubmit}>
                  <div className="form-group">
                    <input
                      className="form-control form-control-lg"
                      type="text"
                      required
                      {...usuario}
                    />
                  </div>
                  <div className="form-group">
                    <input
                      type="password"
                      className="form-control form-control-lg"
                      placeholder="Contraseña"
                      required
                      {...password}
                    />
                  </div>
                  <div className="mt-3">
                    <button
                      type="submit"
                      className="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn"
                    >
                      Ingresar
                    </button>
                  </div>

                  <div className="my-2 d-flex justify-content-end align-items-center">
                    <Link to="/recovery" className="auth-link text-black">
                      ¿Olvidaste tu contraseña?
                    </Link>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default memo(Login);
