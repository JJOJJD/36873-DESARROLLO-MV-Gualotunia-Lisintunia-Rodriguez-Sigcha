package com.example.alertamovimiento;

import java.util.ArrayList;
import java.util.List;

public class AlertaRepository {
    private static AlertaRepository instance;
    private final List<EventoMovimiento> eventos = new ArrayList<>();

    private AlertaRepository() {}

    public static synchronized AlertaRepository getInstance() {
        if (instance == null) {
            instance = new AlertaRepository();
        }
        return instance;
    }

    public void agregarEvento(EventoMovimiento evento) {
        eventos.add(0, evento);
    }

    public List<EventoMovimiento> obtenerEventos() {
        return eventos;
    }

    public void limpiarEventos() {
        eventos.clear();
    }
}
