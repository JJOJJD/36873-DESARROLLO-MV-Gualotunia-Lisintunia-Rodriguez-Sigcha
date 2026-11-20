const http = require('http');

const PORT = 3000;

const ESTADOS_VALIDOS = [
  'Disponible',
  'Entregado',
  'En mantenimiento',
  'Dado de baja',
];

let nextResponsableId = 5;
let nextBienId = 6;
let nextEntregaId = 2;

const responsables = [
  {
    id: 1,
    nombre: 'Ing. Carlos Mendoza',
    tipo: 'Docente',
    departamento: 'Ciencias de la Computación',
    correo: 'cmendoza@espe.edu.ec',
  },
  {
    id: 2,
    nombre: 'Laboratorio de Redes A-204',
    tipo: 'Laboratorio',
    departamento: 'Redes y Telecomunicaciones',
    correo: 'lab.redes@espe.edu.ec',
  },
  {
    id: 3,
    nombre: 'Oficina de Coordinación TI',
    tipo: 'Oficina',
    departamento: 'Sistemas e Informática',
    correo: 'coord.ti@espe.edu.ec',
  },
  {
    id: 4,
    nombre: 'Proyecto IoT SmartCampus',
    tipo: 'Responsable de Proyecto',
    departamento: 'Investigación Aplicada',
    correo: 'iot.smartcampus@espe.edu.ec',
  },
];

const bienes = [
  {
    id: 1,
    codigoInstitucional: 'ESPE-ALM-001',
    nombre: 'Proyector Epson PowerLite X49',
    categoria: 'Equipos Audiovisuales',
    cantidadDisponible: 4,
    cantidadTotal: 4,
    estado: 'Disponible',
  },
  {
    id: 2,
    codigoInstitucional: 'ESPE-ALM-002',
    nombre: 'Laptop Dell Latitude 5430',
    categoria: 'Cómputo',
    cantidadDisponible: 5,
    cantidadTotal: 6,
    estado: 'Disponible',
  },
  {
    id: 3,
    codigoInstitucional: 'ESPE-ALM-003',
    nombre: 'Osciloscopio Digital Tektronix',
    categoria: 'Instrumentación',
    cantidadDisponible: 2,
    cantidadTotal: 2,
    estado: 'Disponible',
  },
  {
    id: 4,
    codigoInstitucional: 'ESPE-ALM-004',
    nombre: 'Switch Cisco Catalyst 2960',
    categoria: 'Redes',
    cantidadDisponible: 1,
    cantidadTotal: 1,
    estado: 'En mantenimiento',
  },
  {
    id: 5,
    codigoInstitucional: 'ESPE-ALM-005',
    nombre: 'Impresora Láser HP Antigua',
    categoria: 'Periféricos',
    cantidadDisponible: 0,
    cantidadTotal: 1,
    estado: 'Dado de baja',
  },
];

const entregas = [
  {
    id: 1,
    bienId: 2,
    bienCodigo: 'ESPE-ALM-002',
    bienNombre: 'Laptop Dell Latitude 5430',
    responsableId: 1,
    responsableNombre: 'Ing. Carlos Mendoza',
    tipoEntrega: 'Temporal',
    fecha: '2026-11-15',
    cantidad: 1,
    condicionEntrega: 'Óptima (con cargador y maletín)',
    observacion: 'Asignada para prácticas de laboratorio móvil',
    devuelta: false,
    fechaDevolucion: null,
    condicionDevolucion: null,
    presentaDano: false,
    fotoPath: null,
  },
];

function sendJson(res, status, data) {
  res.writeHead(status, {
    'Content-Type': 'application/json; charset=utf-8',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type',
  });
  res.end(JSON.stringify(data));
}

function readBody(req) {
  return new Promise((resolve, reject) => {
    let body = '';
    req.on('data', (chunk) => (body += chunk));
    req.on('end', () => {
      if (!body) return resolve({});
      try {
        resolve(JSON.parse(body));
      } catch (e) {
        reject(new Error('JSON inválido'));
      }
    });
  });
}

const server = http.createServer(async (req, res) => {
  if (req.method === 'OPTIONS') {
    return sendJson(res, 204, {});
  }

  const url = req.url.split('?')[0];

  try {
    if (req.method === 'GET' && url === '/api/health') {
      return sendJson(res, 200, { ok: true, service: 'API Guarda de Almacén - Caso 5' });
    }

    // --- RESPONSABLES ---
    if (req.method === 'GET' && url === '/api/responsables') {
      return sendJson(res, 200, responsables);
    }

    if (req.method === 'POST' && url === '/api/responsables') {
      const data = await readBody(req);
      if (!data.nombre || !data.tipo || !data.departamento) {
        return sendJson(res, 400, { error: 'Nombre, tipo y departamento son obligatorios.' });
      }
      const nuevo = {
        id: nextResponsableId++,
        nombre: String(data.nombre).trim(),
        tipo: String(data.tipo).trim(),
        departamento: String(data.departamento).trim(),
        correo: String(data.correo || '').trim(),
      };
      responsables.push(nuevo);
      return sendJson(res, 201, nuevo);
    }

    // --- BIENES ---
    if (req.method === 'GET' && url === '/api/bienes') {
      return sendJson(res, 200, bienes);
    }

    if (req.method === 'POST' && url === '/api/bienes') {
      const data = await readBody(req);
      const codigo = String(data.codigoInstitucional || '').trim().toUpperCase();
      if (!codigo || !data.nombre) {
        return sendJson(res, 400, { error: 'Código institucional y nombre son obligatorios.' });
      }
      if (bienes.some((b) => b.codigoInstitucional.toUpperCase() === codigo)) {
        return sendJson(res, 409, { error: `El código institucional ${codigo} ya existe.` });
      }
      const cantidad = Number(data.cantidadDisponible ?? 1);
      if (isNaN(cantidad) || cantidad < 1) {
        return sendJson(res, 400, { error: 'La cantidad inicial debe ser mayor a 0.' });
      }
      const estado = ESTADOS_VALIDOS.includes(data.estado) ? data.estado : 'Disponible';
      const nuevo = {
        id: nextBienId++,
        codigoInstitucional: codigo,
        nombre: String(data.nombre).trim(),
        categoria: String(data.categoria || 'General').trim(),
        cantidadDisponible: estado === 'Dado de baja' ? 0 : cantidad,
        cantidadTotal: cantidad,
        estado,
      };
      bienes.push(nuevo);
      return sendJson(res, 201, nuevo);
    }

    const bienMatch = url.match(/^\/api\/bienes\/(\d+)$/);
    if (req.method === 'PUT' && bienMatch) {
      const id = Number(bienMatch[1]);
      const bien = bienes.find((b) => b.id === id);
      if (!bien) return sendJson(res, 404, { error: 'Bien no encontrado.' });
      const data = await readBody(req);
      if (bien.estado === 'Dado de baja' && data.estado && data.estado !== 'Dado de baja') {
        return sendJson(res, 400, { error: 'Un bien dado de baja no puede volver a entregarse ni reactivarse.' });
      }
      if (data.estado && ESTADOS_VALIDOS.includes(data.estado)) {
        bien.estado = data.estado;
        if (data.estado === 'Dado de baja') bien.cantidadDisponible = 0;
      }
      return sendJson(res, 200, bien);
    }

    // --- ENTREGAS ---
    if (req.method === 'GET' && url === '/api/entregas') {
      return sendJson(res, 200, entregas);
    }

    if (req.method === 'POST' && url === '/api/entregas') {
      const data = await readBody(req);
      const bien = bienes.find((b) => b.id === Number(data.bienId));
      const resp = responsables.find((r) => r.id === Number(data.responsableId));

      if (!bien) return sendJson(res, 404, { error: 'El bien seleccionado no existe.' });
      if (!resp) return sendJson(res, 400, { error: 'Toda entrega debe estar asociada a un responsable.' });
      if (bien.estado === 'Dado de baja') {
        return sendJson(res, 400, { error: 'Un bien dado de baja no puede volver a entregarse.' });
      }
      if (bien.estado !== 'Disponible') {
        return sendJson(res, 400, { error: `El bien no está Disponible (estado actual: ${bien.estado}).` });
      }
      const cantidad = Number(data.cantidad);
      if (isNaN(cantidad) || cantidad <= 0) {
        return sendJson(res, 400, { error: 'La cantidad entregada debe ser mayor a 0.' });
      }
      if (cantidad > bien.cantidadDisponible) {
        return sendJson(res, 400, {
          error: `Cantidad (${cantidad}) supera lo disponible (${bien.cantidadDisponible}).`,
        });
      }

      bien.cantidadDisponible -= cantidad;
      if (bien.cantidadDisponible === 0) {
        bien.estado = 'Entregado';
      }

      const nueva = {
        id: nextEntregaId++,
        bienId: bien.id,
        bienCodigo: bien.codigoInstitucional,
        bienNombre: bien.nombre,
        responsableId: resp.id,
        responsableNombre: resp.nombre,
        tipoEntrega: data.tipoEntrega || 'Temporal',
        fecha: data.fecha || new Date().toISOString().split('T')[0],
        cantidad,
        condicionEntrega: String(data.condicionEntrega || 'Buena').trim(),
        observacion: String(data.observacion || '').trim(),
        devuelta: false,
        fechaDevolucion: null,
        condicionDevolucion: null,
        presentaDano: false,
        fotoPath: data.fotoPath || null,
      };
      entregas.unshift(nueva);
      return sendJson(res, 201, { entrega: nueva, bien });
    }

    const devolverMatch = url.match(/^\/api\/entregas\/(\d+)\/devolver$/);
    if (req.method === 'PUT' && devolverMatch) {
      const id = Number(devolverMatch[1]);
      const entrega = entregas.find((e) => e.id === id);
      if (!entrega) return sendJson(res, 404, { error: 'Entrega no encontrada.' });
      if (entrega.devuelta) return sendJson(res, 400, { error: 'Esta entrega ya fue devuelta.' });

      const data = await readBody(req);
      if (!data.condicionDevolucion || !String(data.condicionDevolucion).trim()) {
        return sendJson(res, 400, { error: 'Debe registrar la condición de devolución.' });
      }

      const bien = bienes.find((b) => b.id === entrega.bienId);
      const presentaDano = Boolean(data.presentaDano);

      entrega.devuelta = true;
      entrega.fechaDevolucion = data.fechaDevolucion || new Date().toISOString().split('T')[0];
      entrega.condicionDevolucion = String(data.condicionDevolucion).trim();
      entrega.presentaDano = presentaDano;

      if (bien && bien.estado !== 'Dado de baja') {
        bien.cantidadDisponible += entrega.cantidad;
        bien.estado = presentaDano ? 'En mantenimiento' : 'Disponible';
      }

      return sendJson(res, 200, { entrega, bien });
    }

    return sendJson(res, 404, { error: 'Ruta no encontrada' });
  } catch (err) {
    return sendJson(res, 500, { error: err.message });
  }
});

server.listen(PORT, '0.0.0.0', () => {
  console.log(`API Guarda de Almacén (Caso 5) corriendo en http://localhost:${PORT}`);
});
