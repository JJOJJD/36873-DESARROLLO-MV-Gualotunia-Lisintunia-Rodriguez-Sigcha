package com.example.alertamovimiento;

import android.os.Bundle;
import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;
import com.google.android.material.bottomnavigation.BottomNavigationView;

public class MainActivity extends AppCompatActivity {

    private BottomNavigationView bottomNav;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        bottomNav = findViewById(R.id.bottom_navigation);
        bottomNav.setOnItemSelectedListener(item -> {
            int id = item.getItemId();
            if (id == R.id.nav_inicio) {
                getSupportFragmentManager()
                        .beginTransaction()
                        .replace(R.id.fragment_container, new InicioFragment())
                        .commit();
                return true;
            }
            Toast.makeText(this, "Módulo asignado a siguiente integrante", Toast.LENGTH_SHORT).show();
            return false;
        });

        if (savedInstanceState == null) {
            bottomNav.setSelectedItemId(R.id.nav_inicio);
        }
    }

    public void navegarASensor() {
        bottomNav.setSelectedItemId(R.id.nav_sensor);
    }
}
