import 'dart:convert';

class Seguridad {
  List<String> arregloCaracteres =
      'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0,Ñ,ñ,\\,\$,.,?,=,!,:,/,_,+,*'
          .split(',');
  List<String> arregloModificador =
      '9z,1y,8x,2w,7v,3u,6t,4s,5r,0q,9P,1O,8N,2M,7A,3B,6C,4D,5E,0F,aZ,bY,cX,dW,eV,gt,Sh,Ri,Qj,Pk,Ol,Nm,Mn,Ao,Bp,Cq,Dr,Es,Ft,Gu,Hv,Iw,Jx,Ky,Lz,1Z,0Q,2Y,9R,3X,8S,4W,zw,ys,xx,wr,vy,uq,tz,sz,ry,qx,Wz,Sy,3w,7Q,s6,T9,Un,Ls,3D,w3,u0,pW,R1'
          .split(',');
  String encriptar(String cadenaConvertir) {
    String cadenaNueva = '';
    for (String letra in cadenaConvertir.split('')) {
      int contador = arregloCaracteres.indexOf(letra);
      if (contador != -1) {
        cadenaNueva += arregloModificador[contador];
      }
    }
    String cadenaNueva2 = '';
    for (String letra in cadenaNueva.split('')) {
      int contador = arregloCaracteres.indexOf(letra);
      if (contador != -1) {
        cadenaNueva2 += arregloModificador[contador];
      }
    }
    String cadenaFinal = base64.encode(utf8.encode(cadenaNueva2));
    return cadenaFinal;
  }

  String desencriptar(String cadenaEncriptada) {
    String cadenaNueva2 = utf8.decode(base64.decode(cadenaEncriptada));
    String cadenaNueva = '';
    for (int i = 0; i < cadenaNueva2.length; i += 2) {
      String parLetras = cadenaNueva2.substring(i, i + 2);
      int indice = arregloModificador.indexOf(parLetras);
      if (indice != -1) {
        cadenaNueva += arregloCaracteres[indice];
      }
    }
    String cadenaDesencriptada = '';
    for (int i = 0; i < cadenaNueva.length; i += 2) {
      String parLetras = cadenaNueva.substring(i, i + 2);
      int indice = arregloModificador.indexOf(parLetras);
      if (indice != -1) {
        cadenaDesencriptada += arregloCaracteres[indice];
      }
    }
    return cadenaDesencriptada;
  }
}
