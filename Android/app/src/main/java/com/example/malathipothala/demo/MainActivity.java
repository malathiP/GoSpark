package com.example.malathipothala.demo;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        TextView button = findViewById(R.id.messageLabel);
        button.setText(getString(R.string.TapMe));
    }


    public void TapMe(View view)
    {
        Log.e("test",view.getId()+"");
        switch (view.getId()) {
            case R.id.secondButton:
                Log.d("second",""+view.getId());
                System.out.println("test");

                break;
            case R.id.firstButton:
                Log.d("thrid",""+view.getId());

                break;
        }
//        Toast.makeText(getApplicationContext(),"test",Toast.LENGTH_LONG).show();
    }
}
