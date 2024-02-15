import Image from 'mui-image'
import { useContext, useState } from 'react'
import { styled } from '@mui/material/styles'
import { Outlet, NavLink, useNavigate } from 'react-router-dom'
import {
  Box,
  Drawer,
  CssBaseline,
  Toolbar,
  List,
  Divider,
  IconButton,
  ListItemButton,
  ListItemIcon,
  Avatar, Badge,
  Collapse,
  Input,
  InputAdornment,
  ListSubheader,
  Menu,
  Typography,
  Fade,
  ListItem,
  ListItemText,
  Paper,
  Tooltip,
  Button
} from '@mui/material'
import MuiAppBar from '@mui/material/AppBar'
import {
  Bell,
  Box as BoxIcon,
  ChevronDown,
  ChevronUp,
  Circle,
  Menu as MenuIcon,
  Search,
  X,
  Sliders,
  Grid,
  User,
  ShoppingBag,
  FileText,
  Edit,
  LogOut
} from 'react-feather'
import { UsuarioContext } from '../context/UsuarioContext'
import { NotificationContext } from '../context/NotificationConext'
import { useToggle } from '../hooks/useToggle'
const drawerWidth = 240
const styles = {
  listItemButton: {
    '&:hover': {
      color: '#FF5100',
      transform: 'scale(1.01)'
    }
  },
  listItemText: {
    '& .MuiTypography-root': {
      fontSize: 14,
      color: 'grey.100',
      '&:hover': {
        color: '#FF5100'
      }
    }
  },
  listSubheader: {
    color: '#fff',
    padding: '10px 20px',
    backgroundColor: 'primary.main',
    '& .MuiTypography-root': {
      fontSize: 11,
      fontFamily: 'Roboto'
    }
  },
  badge: {
    '& .MuiBadge-badge': {
      top: 0,
      right: 0,
      width: 16,
      height: 16,
      fontSize: 10,
      color: '#fff',
      backgroundColor: 'secondary.main'
    }
  },
  list: { display: 'flex', alignItems: 'center' },
  block: { display: 'block' },
  drawer: {
    width: drawerWidth,
    flexShrink: 0,
    '& .MuiDrawer-paper': {
      color: 'grey.100',
      width: drawerWidth,
      boxSizing: 'border-box',
      backgroundColor: 'primary.main'
    }
  },
  divider: {
    backgroundColor: 'grey.600'
  },
  name: {
    fontFamily: 'Roboto, Helvetica, Arial, sans-serif',
    fontSize: '16px',
    fontWeight: 'bold',
    mt: 2
  },
  email: {
    color: 'grey.500',
    fontFamily: 'Roboto, Helvetica, Arial, sans-serif',
    fontSize: '12px'
  },
  menuItem: {
    minWidth: 'auto',
    marginRight: '16px'
  },
  boxMenu: {
    width: '100%',
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    justifyContent: 'center',
    my: 2
  }
}

const Main = styled('main', { shouldForwardProp: (prop) => prop !== 'open' })(
  ({ theme, open }) => ({
    backgroundColor: '#F9FBFA',
    boxSizing: 'border-box',
    flexGrow: 1,
    padding: window.innerWidth < 600 ? '17px' : theme.spacing(3),
    transition: theme.transitions.create('margin', {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.leavingScreen
    }),
    marginLeft: `-${drawerWidth}px`,
    ...(open && {
      transition: theme.transitions.create('margin', {
        easing: theme.transitions.easing.easeOut,
        duration: theme.transitions.duration.enteringScreen
      }),
      marginLeft: 0
    })
  })
)

const AppBar = styled(MuiAppBar, { shouldForwardProp: (prop) => prop !== 'open' })(({ theme, open }) => ({
  transition: theme.transitions.create(['margin', 'width'], {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen
  }),
  ...(open && {
    width: `calc(100% - ${drawerWidth}px)`,
    marginLeft: `${drawerWidth}px`,
    transition: theme.transitions.create(['margin', 'width'], {
      easing: theme.transitions.easing.easeOut,
      duration: theme.transitions.duration.enteringScreen
    })
  })
}))

const NavbarContent = () => {
  const navigate = useNavigate()
  const [notification, setNotification] = useContext(NotificationContext)
  const [usuarioContext, setUsuarioContext] = useContext(UsuarioContext)
  console.log(usuarioContext, 'usuarioContext')
  const logout = () => {
    setUsuarioContext(null)
    localStorage.removeItem('usuario')
    navigate('/login')
  }
  const handleNotificationDelete = () => setNotification([])

  const profileToggle = useToggle()
  const notificationToggle = useToggle()
  const calculaTiempo = (fecha) => {
    const fechaActual = new Date()
    const fechaNotificacion = new Date(fecha)
    const diferencia = fechaActual.getTime() - fechaNotificacion.getTime()
    const minutos = Math.floor(diferencia / (1000 * 60))
    const horas = Math.floor(diferencia / (1000 * 60 * 60))
    const dias = Math.floor(diferencia / (1000 * 60 * 60 * 24))
    const segundos = Math.floor(diferencia / 1000)
    if (segundos < 60) return `${segundos} segundos`
    if (minutos < 60) return `${minutos} minutos`
    if (horas < 24) return `${horas} horas`
    return `${dias} dias`
  }
  return (
    <>
      <List sx={styles.list}>
        <ListItem disablePadding sx={styles.block}>
          <ListItemButton>
            <Grid size={21} />
          </ListItemButton>
        </ListItem>
        <ListItem disablePadding sx={styles.block}>
          <ListItemButton id="fade-notification"
            aria-controls={notificationToggle.open ? 'fade-notification' : undefined}
            aria-haspopup="true"
            aria-expanded={notificationToggle.open ? 'true' : undefined}
            onClick={notificationToggle.handleClick}>
            <Tooltip title="Notificaciones">
              <Badge badgeContent={notification.length} sx={styles.badge} color="primary">
                <Bell size={21} />
              </Badge>
            </Tooltip>
          </ListItemButton>
        </ListItem>
        <ListItem disablePadding sx={styles.block}>
          <ListItemButton id="fade-profile"
            aria-controls={profileToggle.open ? 'fade-profile' : undefined}
            aria-haspopup="true"
            aria-expanded={profileToggle.open ? 'true' : undefined}
            onClick={profileToggle.handleClick}>
            <Tooltip title="Perfil">
              <Avatar alt="Remy Sharp" src="https://www.posibilidades.com.mx/4cap2023/assets/images/faces/face1.jpg" sx={{ width: 30, height: 30 }} />
            </Tooltip>
          </ListItemButton>
        </ListItem>
      </List>
      <Menu
        id="fade-profile"
        MenuListProps={{ 'aria-labelledby': 'fade-profile' }}
        anchorEl={profileToggle.anchorEl}
        open={profileToggle.open}
        onClose={profileToggle.handleClose}
        TransitionComponent={Fade}
        elevation={1}
      >
        <Paper sx={{ width: 232 }} elevation={0}
        >
          <Box sx={styles.boxMenu}>
            <Avatar alt="profile image" src="https://www.posibilidades.com.mx/4cap2023/assets/images/faces/face1.jpg" sx={{ width: 80, height: 80 }} />
            <Typography sx={styles.name} >Amiah Burton</Typography>
            <Typography sx={styles.email}>
              amiahburton@gmail.com
            </Typography>
          </Box>
          <Divider />
          <List dense>
            <ListItem disablePadding>
              <ListItemButton>
                <ListItemIcon sx={styles.menuItem}>
                  <User size={16} />
                </ListItemIcon>
                <ListItemText primary='Perfil' />
              </ListItemButton>
            </ListItem>
            <ListItem disablePadding>
              <ListItemButton>
                <ListItemIcon sx={styles.menuItem}>
                  <Edit size={16} />
                </ListItemIcon>
                <ListItemText primary='Editar Perfil' />
              </ListItemButton>
            </ListItem>
            <ListItem disablePadding>
              <ListItemButton onClick={logout}>
                <ListItemIcon sx={styles.menuItem}>
                  <LogOut size={16} />
                </ListItemIcon>
                <ListItemText primary='Cerrar sesión' />
              </ListItemButton>
            </ListItem>
          </List>
        </Paper>
      </Menu>
      <Menu
        id="fade-notification"
        MenuListProps={{ 'aria-labelledby': 'fade-notification' }}
        anchorEl={notificationToggle.anchorEl}
        open={notificationToggle.open}
        onClose={notificationToggle.handleClose}
        TransitionComponent={Fade}
        elevation={1}
      >
        <Paper sx={{ width: 260 }} elevation={0}
        >
          <Typography
            sx={{
              fontSize: 14,
              fontWeight: 500,
              color: 'text.primary',
              p: 1.3
            }}>
            {`${notification.length} Nuevas notificaciones `}
            {
              notification.length > 0 && <Button size="small" onClick={handleNotificationDelete} variant="text">
                Limpiar
              </Button>
            }

          </Typography>
          <Divider />
          <List dense>
            {notification.map((item, index) => (
              <div key={index}>
                <ListItem disablePadding >
                  <ListItemButton>
                    <ListItemIcon sx={styles.menuItem} >
                      <Bell size={16} color={item.type} />
                    </ListItemIcon>
                    <ListItemText primary={item.message} secondary={calculaTiempo(item.createdAt)} />
                  </ListItemButton>
                </ListItem>
                <Divider />
              </div>
            ))}
          </List>
          {notification.length > 0 && (
            <>
              <Divider />
              <Button fullWidth variant="text" color='info' size="small">Ver todo</Button>
            </>
          )}
          {notification.length === 0 && (
            <Box sx={{ p: 1.3 }}>
              <Typography
                sx={{
                  fontSize: 14,
                  fontWeight: 500,
                  color: 'text.primary',
                  textAlign: 'center'
                }}>No hay notificaciones
              </Typography>
            </Box>)
          }
        </Paper>
      </Menu>
    </>
  )
}

const DrawerHeader = styled('div')(({ theme }) => ({
  display: 'flex',
  alignItems: 'center',
  padding: theme.spacing(0, 1),
  // necessary for content to be below app bar
  ...theme.mixins.toolbar,
  justifyContent: 'space-around'
}))

// eslint-disable-next-line react/prop-types
const SubHeader = ({ title }) => (
  <ListSubheader sx={styles.listSubheader} component="div" id="nested-list-subheader">
    <Typography variant='h6'>{title}</Typography>
  </ListSubheader>
)

// eslint-disable-next-line react/prop-types
const ListItemLink = ({ name, to, Icon }) => (
  <ListItem disablePadding>
    <ListItemButton component={NavLink} to={to} sx={styles.listItemButton}>
      <ListItemIcon>
        <Icon size={18} color="#6571ff" />
      </ListItemIcon>
      <ListItemText primary={name} sx={styles.listItemText} />
    </ListItemButton>
  </ListItem>
)

// eslint-disable-next-line react/prop-types
const ListItemCollapse = ({ name, Icon, tos, active = false }) => {
  const [open, setOpen] = useState(active)

  const handleClick = () => {
    setOpen(!open)
  }
  return (
    <>
      <ListItemButton onClick={handleClick} sx={styles.listItemButton}>
        <ListItemIcon>
          <Icon size={18} color="#6571ff" />
        </ListItemIcon>
        <ListItemText sx={styles.listItemText} primary={name} />
        {open ? <ChevronDown size={20} color="white" /> : <ChevronUp size={20} color="#6571ff" />}
      </ListItemButton>
      <Collapse in={open} timeout="auto" unmountOnExit>
        <List component="div" disablePadding>
          {
            // eslint-disable-next-line react/prop-types
            tos.map((to, index) => (
              <ListItemButton key={index} sx={{ ...styles.listItemButton, pl: 3 }} component={NavLink} to={to.to}>
                <ListItemIcon>
                  <Circle size={7} color="white" />
                </ListItemIcon>
                <ListItemText primary={to.name} sx={styles.listItemText} />
              </ListItemButton>
            ))
          }
        </List>
      </Collapse>
    </>
  )
}
const DrawerContent = () => {
  let configuraciones = [
    {
      name: 'Puestos',
      to: '/configuraciones/puestos'
    },
    {
      name: 'Departamentos',
      to: '/configuraciones/departamentos'
    },
    {
      name: 'Monedas',
      to: '/configuraciones/monedas'
    },
    {
      name: 'Impuestos',
      to: '/configuraciones/impuestos'
    },
    {
      name: 'Unidades',
      to: '/configuraciones/unidades'
    },
    {
      name: 'Familias',
      to: '/configuraciones/familias'
    },
    {
      name: 'Lineas',
      to: '/configuraciones/lineas'
    },
    {
      name: 'Marcas',
      to: '/configuraciones/marcas'
    },
    {
      name: 'Usuarios',
      to: '/configuraciones/usuarios'
    }
  ]
  // const inventarios = []
  const pedidosInternos = [
    {
      name: 'Pedidos Internos',
      to: '/pedidos-internos/pedidos'
    },
    {
      name: 'Autorizar Pedidos',
      to: '/pedidos-internos/autorizar'
    },
    {
      name: 'Subir Pedidos',
      to: '/pedidos-internos/subir-pedidos'
    }
  ]

  const example = [
    {
      name: 'Usuarios',
      to: '/example/usuarios'
    },
    {
      name: 'Productos',
      to: '/example/productos'
    }
  ]

  configuraciones = configuraciones.sort((a, b) => a.name.localeCompare(b.name))
  return (
    <nav >
      <Divider sx={styles.divider} />
      <List subheader={<SubHeader title='Menu' />}>
        <ListItemLink name='Dashboard' to="/dashboard" Icon={BoxIcon} />
        <ListItemLink name='Mis Datos' to="/usuarios/datos" Icon={User} />
        <ListItemCollapse name='Configuraciones' Icon={Sliders} tos={configuraciones} />
        {/* <ListItemCollapse name='Inventario' Icon={Package} tos={inventarios} /> */}
        <ListItemCollapse name='Pedidos Internos' Icon={ShoppingBag} tos={pedidosInternos} />
        <Divider sx={styles.divider} />
        <ListItemCollapse name='Ejemplo Usuarios' tos={example} Icon={FileText} />
      </List>
      <Divider sx={styles.divider} />
    </nav>
  )
}
const AuthLayout = () => {
  const [open, setOpen] = useState(() => window.innerWidth > 960)
  const handleDrawerOpen = () => {
    setOpen(true)
  }

  const handleDrawerClose = () => {
    setOpen(false)
  }

  return (
    <Box sx={{ display: 'flex' }}>
      <CssBaseline />
      <AppBar position="fixed" open={open} color='white' elevation={1}>
        <Toolbar>
          <IconButton
            edge="start"
            aria-label="open drawer"
            onClick={handleDrawerOpen}
            sx={{ marginRight: 5, ...(open && { display: 'none' }) }}
          >
            <MenuIcon />
          </IconButton>
          <Input
            fullWidth
            disableUnderline
            placeholder='Buscar...'
            startAdornment={<InputAdornment position="start"><Search size={19} color="grey" /></InputAdornment>}
          />
          <NavbarContent />
        </Toolbar>
      </AppBar>
      <Drawer
        open={open}
        anchor="left"
        sx={styles.drawer}
        variant="persistent"
      >
        <DrawerHeader>
          <NavLink to='/dashboard'>
            <Image src='https://www.posibilidades.com.mx/4cap2023/images/logo/logo_4cap_300x100.svg' alt='logo' width={120} height={40} duration={0} />
          </NavLink>
          <IconButton
            sx={{ color: 'grey.100' }}
            onClick={handleDrawerClose}>
            <X size={23} />
          </IconButton>
        </DrawerHeader>
        <DrawerContent />
      </Drawer>
      <Main open={open}>
        <DrawerHeader />
        <Outlet />
      </Main>
    </Box>
  )
}

export default AuthLayout
