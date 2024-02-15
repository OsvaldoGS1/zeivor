import axios from 'axios'

const URI = 'https://apicap.4cap.xyz/api'

export const apiAuth = (token = '') => axios.create({
  baseURL: URI,
  headers: {
    Authorization: `Bearer ${token}`
  }
})
