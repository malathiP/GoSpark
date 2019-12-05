package com.example.malathipothala.demo;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.PermissionChecker;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.PermissionRequest;
import android.widget.Button;
import android.widget.TextView;

import org.w3c.dom.Text;

import java.security.Permission;

public class LocationActivity extends AppCompatActivity implements LocationListener {


    LocationManager locationManager;
    String passedValue;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.locationactivity);

        Intent intent = getIntent();
        String value = intent.getStringExtra("PassedValue");
        if (value != null) {

            System.out.println("Passedvalue" + value);
        }
        setTitle(String.valueOf("Location"));
        checkPermissions();

        Button currentLocationButton = findViewById(R.id.locationButton);
        currentLocationButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                locationManager = (LocationManager) getSystemService(LOCATION_SERVICE);

               boolean isGps = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER);
                if (isGps) {

                   locationManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER,100,1,LocationActivity.this);
                   Location location = locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER);

                   if (location != null) {

                       String locationString = String.format("long %s: latti %s",location.getLatitude(),location.getLongitude());
                       System.out.println(locationString);
                       TextView locationTextView = findViewById(R.id.locationLabel);
//                       ViewGroup viewGroup = (ViewGroup) locationTextView.getParent();
//                       viewGroup.removeView(locationTextView);
                       locationTextView.setText(locationString);
                   }
                }
            }
        });
    }

    public void checkPermissions() {

        if (ActivityCompat.checkSelfPermission(this,Manifest.permission.ACCESS_FINE_LOCATION) != PermissionChecker.PERMISSION_GRANTED ) {

            Log.d(LocationActivity.class.toString(),"Permission denied");
            ActivityCompat.requestPermissions(this,new String[]{Manifest.permission.ACCESS_FINE_LOCATION},PermissionChecker.PERMISSION_GRANTED);
        }else {

            Log.d(LocationActivity.class.toString(),"Permission granted");

        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        switch (requestCode) {

            case PermissionChecker.PERMISSION_GRANTED:
                System.out.println("Accepted");

                break;
            default:

                break;
        }
    }

    /**
     *
     * @param location
     */
    @Override
    public void onLocationChanged(Location location) {

        System.out.println("Location changed with "+"Lattitude : " +location.getLatitude() + "Logitude : " + location.getLongitude());

    }

    @Override
    public void onStatusChanged(String provider, int status, Bundle extras) {

        System.out.println("onStatusChanged");

    }

    @Override
    public void onProviderEnabled(String provider) {

    }

    @Override
    public void onProviderDisabled(String provider) {

    }
}
