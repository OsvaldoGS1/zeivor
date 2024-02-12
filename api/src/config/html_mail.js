const HtmlCorreo = {
  plantilla(nombre, usuario, contrasena, year) {
    let html = `<table border="0" cellspacing="0" cellpadding="0" style="width:100%; background-color:#FFFFFF;margin:0px !important;">
          <tr>
              <td style="width:100%; padding:20px;">
                  <table style="width:700px;" border="0" align="center" cellpadding="0" cellspacing="0">
                      <tr>
                          <td style="width:100%;background-color: #FD495C !important; padding: 20px;  vertical-align:top;">
                              <table style="width:100%;" border="0" align="center" cellpadding="0" cellspacing="0">
                                  <tr>
                                      <td style="width:50%; text-align:left; vertical-align:middle;"><img
                                              src="https://seivor.com/imagenes/logo.jpg"
                                              width="215" title="SEIVOR" alt="SEIVOR" /></td>
                                      <td
                                          style="width:50%; text-align:right; vertical-align:middle; font-family: Arial, Helvetica, sans-serif; font-size:18px; color:#0F181F; font-weight:bold;">
                                          <table border="0" align="center" cellpadding="0" cellspacing="0"
                                              style="width:100%;">
                                              <tr>
                                                  <td
                                                      style="width:100%;font-family: Arial, Helvetica, sans-serif; font-size:16px; color:#FFFFFF; font-weight:bold; padding-bottom:5px; text-align:right; text-transform:uppercase;">
                                                      Bienvenido a ZEIVOR</td>
                                              </tr>
                                              <tr>
                                                  <td
                                                      style="width:100%;font-family: Arial, Helvetica, sans-serif; font-size:15px; color:#FFFFFF; font-weight:normal; text-align:right;">
                                                      Gracias por registrarse</td>
                                              </tr>
                                          </table>
                                      </td>
                                  </tr>
                              </table>
                              <table border="0" align="center" cellpadding="0" cellspacing="0" style="width:100%;">
                                  <tr>
                                      <td
                                          style="width:100%; border-bottom-width:2px; border-bottom-style:solid; border-bottom-color:#CDCDCD;">
                                          &nbsp;</td>
                                  </tr>
                                  <tr>
                                      <td style="width:100%;">&nbsp;</td>
                                  </tr>
                              </table>
                              <table border="0" align="center" cellpadding="0" cellspacing="0" style="width:100%;">
                                  <tr>
                                      <td
                                          style="width:100%; font-family: Arial, Helvetica, sans-serif; font-size:14px; color:#FFFFFF; font-weight:normal; text-align:left;">
                                          Hola ${nombre}, A continuación le enviamos sus datos de acceso a nuestra
                                          plataforma </td>
                                  </tr>
                              </table>
                              <table border="0" align="center" cellpadding="0" cellspacing="0" style="width:100%;">
                                  <tr>
                                      <td style="width:100%;">&nbsp;</td>
                                  </tr>
                              </table>
                              <table style="width:100%;" border="0" align="center" cellpadding="0" cellspacing="0">
                                  <tr>
                                      <td
                                          style="width:30%; background-color:#1D252C; font-family: Arial, Helvetica, sans-serif; font-size:14px; font-weight:bold; color:#FFFFFF; text-align:left; vertical-align:middle; padding:5px; border-right-width:2px; border-right-style:solid; border-right-color:#FFFFFF;border-bottom-width:2px; border-bottom-style:solid; border-bottom-color:#FFFFFF;">
                                          URL:</td>
                                      <td
                                          style="width:70%; background-color:#F2F2F2; font-family: Arial, Helvetica, sans-serif; font-size:14px; font-weight:bold; color:#0F181F; text-align:left; vertical-align:middle; padding:5px;border-right-width:2px; border-right-style:solid; border-right-color:#FFFFFF;border-bottom-width:2px; border-bottom-style:solid; border-bottom-color:#FFFFFF;">
                                          <a style="text-decoration:none;color:#0F181F;" href="https://SEIVOR.com/"
                                              target="_blank">https://SEIVOR.com/</a>
                                      </td>
                                  </tr>
                                  <tr>
                                      <td
                                          style="width:30%; background-color:#1D252C; font-family: Arial, Helvetica, sans-serif; font-size:14px; font-weight:bold; color:#FFFFFF; text-align:left; vertical-align:middle; padding:5px; border-right-width:2px; border-right-style:solid; border-right-color:#FFFFFF;border-bottom-width:2px; border-bottom-style:solid; border-bottom-color:#FFFFFF;">
                                          Usuario:</td>
                                      <td
                                          style="width:70%; background-color:#F2F2F2; font-family: Arial, Helvetica, sans-serif; font-size:14px; font-weight:bold; color:#0F181F; text-align:left; vertical-align:middle; padding:5px;border-right-width:2px; border-right-style:solid; border-right-color:#FFFFFF;border-bottom-width:2px; border-bottom-style:solid; border-bottom-color:#FFFFFF;">
                                          ${usuario}</td>
                                  </tr>
                                  <tr>
                                      <td
                                          style="width:30%; background-color:#1D252C; font-family: Arial, Helvetica, sans-serif; font-size:14px; font-weight:bold; color:#FFFFFF; text-align:left; vertical-align:middle; padding:5px; border-right-width:2px; border-right-style:solid; border-right-color:#FFFFFF;border-bottom-width:2px; border-bottom-style:solid; border-bottom-color:#FFFFFF;">
                                          Password:</td>
                                      <td
                                          style="width:70%; background-color:#FFFFFF; font-family: Arial, Helvetica, sans-serif; font-size:14px; font-weight:bold; color:#0F181F; text-align:left; vertical-align:middle; padding:5px;border-right-width:2px; border-right-style:solid; border-right-color:#FFFFFF;border-bottom-width:2px; border-bottom-style:solid; border-bottom-color:#FFFFFF;">
                                          ${contrasena}</td>
                                  </tr>
                                  <!-- {{-- <tr>
                                      <td
                                          style="width:30%; background-color:#C89211; font-family: Arial, Helvetica, sans-serif; font-size:14px; font-weight:bold; color:#FFFFFF; text-align:left; vertical-align:middle; padding:5px; border-right-width:2px; border-right-style:solid; border-right-color:#FFFFFF;border-bottom-width:2px; border-bottom-style:solid; border-bottom-color:#FFFFFF;">
                                          Manual de usuario</td>
                                      <td
                                          style="width:70%; background-color:#FFFFFF; font-family: Arial, Helvetica, sans-serif; font-size:14px; font-weight:bold; color:#0F181F; text-align:left; vertical-align:middle; padding:5px;border-right-width:2px; border-right-style:solid; border-right-color:#FFFFFF;border-bottom-width:2px; border-bottom-style:solid; border-bottom-color:#FFFFFF;">
                                          <a href="https://bit.ly/3XEw1hZ">Descargar Manual PDF</a>
                                      </td>
                                  </tr> --}} -->
                              </table>
                              <table border="0" align="center" cellpadding="0" cellspacing="0" style="width:100%;">
                                  <tr>
                                      <td style="width:100%;">&nbsp;</td>
                                  </tr>
                              </table>
                              <table border="0" align="center" cellpadding="0" cellspacing="0" style="width:100%;">
                                  <tr>
                                      <td
                                          style="width:100%; border-bottom-width:2px; border-bottom-style:solid; border-bottom-color:#CDCDCD;">
                                          &nbsp;</td>
                                  </tr>
                                  <tr>
                                      <td style="width:100%;">&nbsp;</td>
                                  </tr>
                              </table> 
                              <table border="0" align="center" cellpadding="0" cellspacing="0" style="width:100%;">
                                  <tr>
                                      <td align="center"
                                          style="width:100%; font-family: Arial, Helvetica, sans-serif; font-size:14px; text-align:center; color:#FFFFFF; font-weight:normal;">
                                          También puede descargar la aplicación para:</td>
                                  </tr>
                              </table>
                              <table border="0" align="center" cellpadding="0" cellspacing="0" style="width:100%;">
                                  <tr>
                                      <td style="width:100%;">&nbsp;</td>
                                  </tr>
                              </table>
                              <table border="0" align="center" cellpadding="0" cellspacing="0" style="width:100%;">
                                  <tr>
                                      <td style="width:100%; text-align:center;">
                                          <table border="0" align="center" cellpadding="0" cellspacing="0"
                                              style="width:80%; text-align:center;">
                                              <tr>
                                                  <td align="center" valign="middle" style="width:33%;"><a
                                                          href="https://hank.mx/" target="_blank"><img
                                                              src="https://hank.mx/app/administrador/images/button_website.png"
                                                              title="Visite nuestra Web Site" alt="Visite nuestra Web Site"
                                                              width="130" height="40" /></a></td>
                                                  <td align="center" valign="middle" style="width:33%;"><a
                                                          href="https://www.apple.com/mx/app-store/"
                                                          target="_blank"><img
                                                              src="https://hank.mx/app/administrador/images/button_app_store.png"
                                                              title="Descárguela en App Store"
                                                              alt="Descárguela en App Store" width="130"
                                                              height="40" /></a></td>
                                                  <td align="center" valign="middle" style="width:33%;"><a
                                                          href="https://play.google.com/store/games?hl=es_MX&gl=US&pli=1" target="_blank"><img
                                                              src="https://hank.mx/app/administrador/images/button_google_play.png"
                                                              title="Descárguela en Google Play"
                                                              alt="Descárguela en Google Play" width="130"
                                                              height="40" /></a></td>
                                              </tr>
                                          </table>
                                      </td>
                                  </tr>
                              </table> 
                              <table border="0" align="center" cellpadding="0" cellspacing="0" style="width:100%;">
                                  <tr>
                                      <td
                                          style="width:100%; border-bottom-width:2px; border-bottom-style:solid; border-bottom-color:#CDCDCD;">
                                          &nbsp;</td>
                                  </tr>
                                  <tr>
                                      <td style="width:100%;">&nbsp;</td>
                                  </tr>
                              </table>
                              <table border="0" align="center" cellpadding="0" cellspacing="0" style="width:100%;">
                                  <tr>
                                      <td style="width:100%;">&nbsp;</td>
                                  </tr>
                              </table>
                              <table border="0" align="center" cellpadding="0" cellspacing="0" style="width:100%;">
                                  <tr>
                                      <td align="center"
                                          style="width:100%; font-family: Arial, Helvetica, sans-serif; font-size:12px; text-align:center; color:#5C5A5B; font-weight:normal;">
                                          <a style="color:#FFFFFF; text-decoration:none;" href="https://hank.mx/contacto/"
                                              target="_blank" title="Contacto" alt="Contacto">Contacto</a> | <a
                                              style="color:#FFFFFF; text-decoration:none;"
                                              href="https://hank.mx/aviso_privacidad/" target="_blank"
                                              title="Aviso de Privacidad" alt="Aviso de Privacidad">Aviso de Privacidad</a>
                                          | <a style="color:#FFFFFF; text-decoration:none;" href="#" target="_blank"
                                              title="Políticas de Uso" alt="Políticas de Uso">Políticas de Uso</a>
                                      </td>
                                  </tr>
                              </table>
                              <table border="0" align="center" cellpadding="0" cellspacing="0" style="width:100%;">
                                  <tr>
                                      <td style="width:100%;">&nbsp;</td>
                                  </tr>
                              </table>
                              <table border="0" align="center" cellpadding="0" cellspacing="0" style="width:100%;">
                                  <tr>
                                      <td align="center"
                                          style="width:100%; text-align:center; vertical-align:top; padding-bottom:10px;">
                                          <table border="0" align="center" cellpadding="0" cellspacing="0"
                                              style="width:15%;">
                                              <tr>
                                                  <td align="center" valign="middle" style="width:33%;"><a
                                                          href="https://SEIVOR.com/" target="_blank"><img
                                                              src="https://SEIVOR.com/images/icono.png"
                                                              width="40" height="40"
                                                              title="SEIVOR Transferencias Rapidas"
                                                              alt="SEIVOR Transferencias Rapidas" /></a></td>
                                                  <td align="center" valign="middle" style="width:33%;"><a
                                                          href="https://www.posibilidades.com.mx/" target="_blank"><img
                                                              src="https://hank.mx/app/administrador/images/icono_psd.png"
                                                              width="20" height="20" title="Grupo Posibilidades"
                                                              alt="Grupo Posibilidades" /></a></td>
      
                                              </tr>
                                          </table>
                                      </td>
                                  </tr>
                              </table>
                              <table border="0" align="center" cellpadding="0" cellspacing="0" style="width:100%;">
                                  <tr>
                                      <td align="center"
                                          style="width:100%; font-family: Arial, Helvetica, sans-serif; font-size:12px; text-align:center; color:#FFFFFF; font-weight:normal;">
                                          © ${year} <a
                                              style="color:#FFFFFF; font-weight:normal; text-decoration:none;"
                                              href="https://SEIVOR.com" target="_blank" title="SEIVOR"
                                              alt="SEIVOR">zeivor </a> | Design by: <a
                                              style="color:#FFFFFF; font-weight:normal; text-decoration:none;"
                                              href="https://www.posibilidades.com.mx/" target="_blank"
                                              title="Design by: Posibilidades"
                                              alt="Design by: Posibilidades">Posibilidades</a></td>
                                  </tr>
                              </table>
                          </td>
                      </tr>
                  </table>
              </td>
          </tr>
      </table>`;
    return html;
  },
};

module.exports = { HtmlCorreo };
