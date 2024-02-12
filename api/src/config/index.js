const PORT = process.env.PORT || 3000; //Puerto del servidor

// Credenciales para conexion a DB Remota
// export const DB_HOST = process.env.DB_HOST || '174.136.25.254'
// export const DB_USER = process.env.DB_USER || 'esnaby_usfepneg'
// export const DB_PASSWORD = process.env.DB_PASSWORD || 'T(r3wIpu;EZH'
// export const DB_DATABASE = process.env.DB_DATABASE || 'esnaby_fepneg'
// export const DB_PORT = process.env.DB_PORT || 3306

//Credenciales para conexion DB Prueba (Remota)
const DB_HOST = process.env.DB_HOST || "174.136.25.254";
const DB_USER = process.env.DB_USER || "seivor_user";
const DB_PASSWORD = process.env.DB_PASSWORD || "N94c5i}y3]}0";
const DB_DATABASE = process.env.DB_DATABASE || "seivor_bd";
const DB_PORT = process.env.DB_PORT || 3306;

const CORS_ORIGIN = process.env.CORS_ORIGIN || "*";

const TOKEN_SECRET =
  process.env.TOKEN_SECRET || "RrgZOalwqDNQQZ3uPSRK7zzDBm5EwRRb";
const TOKEN_EXPIRES_IN = process.env.TOKEN_EXPIRES_IN || "1d";

const FIREBASE_KEY =
  "AAAAxbKCuKo:APA91bHrTg4SH-bdCnark8sx-Ty1m0RpwgyEtxeVWFN4dhwoLdqLvyZgMGfHnumfFoZ7T3ugqIQTmC9uC-J_Peml85sE6dO2AK6iIu-b05IbsbJCQM-cyO5yAKmUaF3uT8uJp7xcKhSd";

module.exports = {
  PORT,
  DB_HOST,
  DB_USER,
  DB_PASSWORD,
  DB_DATABASE,
  DB_PORT,
  CORS_ORIGIN,
  TOKEN_SECRET,
  TOKEN_EXPIRES_IN,
  FIREBASE_KEY,
};
