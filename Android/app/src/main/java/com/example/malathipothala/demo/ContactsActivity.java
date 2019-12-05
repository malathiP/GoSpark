package com.example.malathipothala.demo;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.annotation.RequiresPermission;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.RecyclerView;

import java.util.ArrayList;
import java.util.Arrays;


public class ContactsActivity extends AppCompatActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.contactsactivity);
        setTitle("Contacts");

       RecyclerView recycleListView = findViewById(R.id.contactsRecyclerView);
        RecycleAdapter recycleAdapter = new RecycleAdapter((ArrayList) Arrays.asList("a","b","c"));
        recycleListView.setAdapter(recycleAdapter);

    }

}
