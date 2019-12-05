package com.example.malathipothala.demo;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.ImageView;

public class AnimationsAcitivity extends AppCompatActivity {

    String[] fruits = {"Apple", "Banana", "Cherry", "Date", "Grape", "Kiwi", "Mango", "Pear"};

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setTitle("Animations");
        setContentView(R.layout.animationsactivity);
        ArrayAdapter<String> adapter = new ArrayAdapter<String>
                (this, android.R.layout.select_dialog_item, fruits);
        AutoCompleteTextView textView = findViewById(R.id.autoCompleteTextView);
        textView.setAdapter(adapter);
        textView.setThreshold(1);
    }

    @Override
    protected void onStart() {
        super.onStart();

    }

    public void clickAnimate(View view) {

        ImageView imageView = findViewById(R.id.animateImageView);
        Animation animation = AnimationUtils.loadAnimation(this,R.anim.fade);
        imageView.startAnimation(animation);
    }
}
