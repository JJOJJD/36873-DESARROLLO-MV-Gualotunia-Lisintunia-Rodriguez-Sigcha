package com.example.alertamovimiento;

import android.content.Context;
import android.graphics.Color;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import com.google.android.material.button.MaterialButton;

public class InicioFragment extends Fragment {

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater,
                             @Nullable ViewGroup container,
                             @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_inicio, container, false);

        TextView tvHardware = view.findViewById(R.id.tv_estado_hardware);
        TextView tvResumen = view.findViewById(R.id.tv_resumen_eventos);
        MaterialButton btnIrSensor = view.findViewById(R.id.btn_ir_sensor);

        SensorManager sm = (SensorManager) requireContext().getSystemService(Context.SENSOR_SERVICE);
        Sensor acelerometro = sm != null ? sm.getDefaultSensor(Sensor.TYPE_ACCELEROMETER) : null;

        if (acelerometro != null) {
            tvHardware.setText("Acelerómetro disponible: " + acelerometro.getName());
            tvHardware.setTextColor(Color.parseColor("#1E293B"));
        } else {
            tvHardware.setText("Error: este dispositivo no dispone de acelerómetro.");
            tvHardware.setTextColor(Color.parseColor("#D97706"));
        }

        int total = AlertaRepository.getInstance().obtenerEventos().size();
        tvResumen.setText("Eventos registrados en esta sesión: " + total);

        btnIrSensor.setOnClickListener(v -> {
            if (getActivity() instanceof MainActivity) {
                ((MainActivity) getActivity()).navegarASensor();
            }
        });

        return view;
    }
}
