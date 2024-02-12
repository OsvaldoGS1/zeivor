const crypto = require("crypto");
const Security = {
  encriptar(cadenaConvertir) {
    const arregloCaracteres =
      "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0,Ñ,ñ,\\,$,.,?,=,!,:,/,_,+,*".split(
        ","
      );

    const arregloModificador =
      "9z,1y,8x,2w,7v,3u,6t,4s,5r,0q,9P,1O,8N,2M,7A,3B,6C,4D,5E,0F,aZ,bY,cX,dW,eV,gt,Sh,Ri,Qj,Pk,Ol,Nm,Mn,Ao,Bp,Cq,Dr,Es,Ft,Gu,Hv,Iw,Jx,Ky,Lz,1Z,0Q,2Y,9R,3X,8S,4W,zw,ys,xx,wr,vy,uq,tz,sz,ry,qx,Wz,Sy,3w,7Q,s6,T9,Un,Ls,3D,w3,u0,pW,R1".split(
        ","
      );

    let cadenaNueva = "";
    for (const letra of cadenaConvertir) {
      const contador = arregloCaracteres.indexOf(letra);
      if (contador !== -1) {
        cadenaNueva += arregloModificador[contador];
      }
    }

    let cadenaNueva2 = "";
    for (const letra of cadenaNueva) {
      const contador = arregloCaracteres.indexOf(letra);
      if (contador !== -1) {
        cadenaNueva2 += arregloModificador[contador];
      }
    }

    const cadenaFinal = Buffer.from(cadenaNueva2, "utf-8").toString("base64");
    return cadenaFinal;
  },

  desencriptar(cadenaEncriptada) {
    const arregloCaracteres =
      "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0,Ñ,ñ,\\,$,.,?,=,!,:,/,_,+,*".split(
        ","
      );

    const arregloModificador =
      "9z,1y,8x,2w,7v,3u,6t,4s,5r,0q,9P,1O,8N,2M,7A,3B,6C,4D,5E,0F,aZ,bY,cX,dW,eV,gt,Sh,Ri,Qj,Pk,Ol,Nm,Mn,Ao,Bp,Cq,Dr,Es,Ft,Gu,Hv,Iw,Jx,Ky,Lz,1Z,0Q,2Y,9R,3X,8S,4W,zw,ys,xx,wr,vy,uq,tz,sz,ry,qx,Wz,Sy,3w,7Q,s6,T9,Un,Ls,3D,w3,u0,pW,R1".split(
        ","
      );

    let cadenaNueva2 = Buffer.from(cadenaEncriptada, "base64").toString(
      "utf-8"
    );
    let cadenaNueva = "";

    for (let i = 0; i < cadenaNueva2.length; i += 2) {
      const parLetras = cadenaNueva2.substring(i, i + 2);
      const indice = arregloModificador.indexOf(parLetras);
      if (indice !== -1) {
        cadenaNueva += arregloCaracteres[indice];
      }
    }

    let cadenaDesencriptada = "";
    for (let i = 0; i < cadenaNueva.length; i += 2) {
      const parLetras = cadenaNueva.substring(i, i + 2);
      const indice = arregloModificador.indexOf(parLetras);
      if (indice !== -1) {
        cadenaDesencriptada += arregloCaracteres[indice];
      }
    }

    return cadenaDesencriptada;
  },

  generarContrasena() {
    const cadena =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
    const longitudPass = 10;
    let pass = "";

    for (let i = 0; i < longitudPass; i++) {
      const pos = crypto.randomInt(0, cadena.length);
      pass += cadena[pos];
    }

    return pass;
  },
};

module.exports = { Security };
