package com.example.malathipothala.demo;

import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.DialogPreference;
import android.support.annotation.Nullable;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TableLayout;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public class SecondActivity extends AppCompatActivity {
  public enum ListNames {

        LOCATIONS,
        ANIMATIONS,
        CONTACTS

    };
private static final int locations = 0, animations = 1;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.secondactivity);
        ListView listView = findViewById(R.id.categoryListView);
        ArrayList<String> list = new ArrayList<String>(Arrays.asList("Locations","Animations","c","d","e","f","g"));

        ListAdapater listAdapater = new ListAdapater(list,this.getApplicationContext());
        listView.setAdapter(listAdapater);

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {

                switch (position) {

                    case locations:

                        showAlertWithMessage("Choose Options");
                        break;
                    case animations:

                        showAnimations();

                        break;
//                    case contacts:
//
//                        break;

                }

            }
        });

        if (savedInstanceState !=null) {

            String username = savedInstanceState.getString("username");
            String password = savedInstanceState.getString("password");
            System.out.println("username :"+username+"password: "+password);
        }
        SharedPreferences sharedPreferences=getSharedPreferences("data",0);
        SharedPreferences.Editor editor=sharedPreferences.edit();
        editor.putString("data","sdf");
        editor.commit();


        sharedPreferences.getString("data","");


    }

    @Override
    protected void onStart() {
        super.onStart();
        System.out.println("Start ");
        setTitle("SecondActivity");

    }

    @Override
    protected void onResume() {
        super.onResume();
        System.out.println("Resume view is apear after start");

    }

    @Override
    protected void onStop() {
        super.onStop();
        System.out.println("Stop after pause");

    }

    @Override
    protected void onPause() {
        super.onPause();
        System.out.println("Pause move from one activity to another ");

    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        System.out.println("Destory while app crashing");

    }

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        outState.putString("username", "malathiP");
        outState.putString("password", "malathi");

    }

    public void showLocationActivity() {

        Intent intent = new Intent(getApplicationContext(),LocationActivity.class);
        intent.putExtra("PassedValue","malathi");
        startActivity(intent);
    }
    public void showAnimations() {

        Intent intent = new Intent(getApplicationContext(),AnimationsAcitivity.class);
        startActivity(intent);
    }
    public void showAlertWithMessage(String mesg){

        final AlertDialog.Builder alertDialog = new AlertDialog.Builder(this);
        alertDialog.setTitle("Alert!");
        alertDialog.setMessage(mesg);
        alertDialog.setPositiveButton("Accept", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {


                        showLocationActivity();
                    }
                }
        );
        alertDialog.setNegativeButton("Choose List Dialog", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {

                dialog.cancel();
                ArrayList colors = new  ArrayList<String>(Arrays.asList("a","b","c"));
                alertDialog.setItems(R.array.colors, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {


                    }
                });
                alertDialog.show();
            }
        });
        alertDialog.show();
    }
}
