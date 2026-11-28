package com.example.alertamovimiento;

public class EventoMovimiento {
    private final String tipo;
    private final String fecha;
    private final String hora;
    private final float x;
    private final float y;
    private final float z;
    private final float intensidad;

    public EventoMovimiento(String tipo, String fecha, String hora,
                            float x, float y, float z, float intensidad) {
        this.tipo = tipo;
        this.fecha = fecha;
        this.hora = hora;
        this.x = x;
        this.y = y;
        this.z = z;
        this.intensidad = intensidad;
    }

    public String getTipo() { return tipo; }
    public String getFecha() { return fecha; }
    public String getHora() { return hora; }
    public float getX() { return x; }
    public float getY() { return y; }
    public float getZ() { return z; }
    public float getIntensidad() { return intensidad; }
}
