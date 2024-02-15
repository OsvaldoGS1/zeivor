/* eslint-disable react/prop-types */
import { memo, useState, useContext } from 'react'
import { Alert, Button, Divider, IconButton, Modal, Tooltip, Typography } from '@mui/material'
import { useQuery, useMutation } from '@tanstack/react-query'
import { Box } from '@mui/system'
import { Columns, Plus, RefreshCcw, Table, X } from 'react-feather'
import DataTable from './DataTable'
import { Kanban } from './Kanban'
import Swal from 'sweetalert2'
import { UsuarioContext } from '../context/UsuarioContext'

const styles = {
  between: {
    display: 'flex',
    justifyContent: 'space-between',
    gap: 1,
    marginBottom: 2
  },
  End: {
    display: 'flex',
    justifyContent: 'flex-end',
    gap: 1,
    marginBottom: 2,
    marginTop: 2
  },
  start: {
    display: 'flex',
    justifyContent: 'flex-start',
    gap: 1
  },
  TextField: {
    mb: 2
  },
  modal: {
    position: 'absolute',
    top: '50%',
    left: '50%',
    transform: 'translate(-50%, -50%)',
    minWidth: '350px',
    width: '100%',
    maxWidth: '500px',
    bgcolor: 'white',
    p: 4,
    boxShadow: 24,
    '&:focus': {
      outline: 'none'
    }
  },
  title: {
    color: 'primary.main',
    textTransform: 'uppercase',
    fontWeight: 'bold',
    mb: 2
  },
  titleAdd: {
    color: 'primary.main',
    textTransform: 'uppercase',
    fontWeight: 'bold'
  }
}

const Listar = ({ FormCreate, title, ObtenerData, Delete, heads }) => {
  const [openCreate, setOpenCreate] = useState(false)
  const [usuarioContext] = useContext(UsuarioContext)
  const { token, empresa } = usuarioContext

  const { isLoading, data, isError, refetch } = useQuery({
    queryKey: [title.toLowerCase()],
    queryFn: () => ObtenerData({ token, empresa })
  })
  const deleteMutation = useMutation({
    mutationFn: Delete,
    onSuccess: (s) => {
      Swal.fire({ title: 'Eliminado correctamente', icon: 'success' })
      refetch()
    },
    onError: (error) => {
      const message = error.response?.data?.message || error.message
      Swal.fire({ title: 'Error al eliminar', text: message, icon: 'error' })
    }
  })

  const [tableOrKanban, setTableOrKanban] = useState(true)

  // eslint-disable-next-line camelcase
  const handleDelete = async (obj) => {
    const id = Object.values(obj)[0]
    const { isConfirmed } = await Swal.fire({
      title: '¿Estas seguro de eliminarlo?',
      showDenyButton: true,
      confirmButtonText: 'Si'
    })

    if (isConfirmed) {
      deleteMutation.mutate({ token, id })
    }
  }
  const handleOpen = () => setOpenCreate(true)
  const handleClose = () => setOpenCreate(false)

  const Render = () => (
    <>
      {isError && <Alert severity='error'>Error al cargar los datos</Alert>}
      {!tableOrKanban
        ? (<Kanban heads={heads} response={data} title={title} loading={isLoading} />)
        : (
          <DataTable
            heads={heads}
            response={data}
            title={title}
            loading={isLoading}
            handleDelete={handleDelete}
          />)
      }
    </>
  )

  return (
    <>
      {isError
        ? <Alert severity='error'>Error al cargar los datos</Alert>
        : <>
          <Typography variant='h5' component='h2' gutterBottom sx={styles.title}>
            {title}
          </Typography>
          <Divider />
          <Box sx={styles.End}>
            <Button variant='outlined' startIcon={<Plus size={17} />} onClick={handleOpen} >
              Altas
            </Button>
            <Tooltip title='Refrescar información'>
              <IconButton onClick={() => refetch()}>
                <RefreshCcw size={17} />
              </IconButton>
            </Tooltip>
            <Button variant='text' startIcon={<Table size={17} />} disabled={tableOrKanban} onClick={() => setTableOrKanban(!tableOrKanban)}>
              Tabla
            </Button>
            <Button variant='text' startIcon={<Columns size={17} />} disabled={!tableOrKanban} onClick={() => setTableOrKanban(!tableOrKanban)}>
              Kanban
            </Button>
          </Box>
          <Render />
          <Modal
            open={openCreate}
            onClose={() => setOpenCreate(false)}
            aria-labelledby="modal-modal-create"
            aria-describedby="modal-modal-description"
          >
            <Box sx={styles.modal}>
              <Box sx={styles.between}>
                <Typography id="modal-modal-create" variant="h6" component="h2" sx={styles.titleAdd}>
                  REGISTRO DE {title}
                </Typography>
                <IconButton aria-label='close' onClick={() => setOpenCreate(false)}>
                  <X size={22} />
                </IconButton>
              </Box>
              <FormCreate close={handleClose} />
            </Box>
          </Modal>
        </>}
    </>
  )
}
export default memo(Listar)
