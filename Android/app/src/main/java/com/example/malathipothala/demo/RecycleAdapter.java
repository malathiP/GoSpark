package com.example.malathipothala.demo;

import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.ViewGroup;

import java.util.ArrayList;

public class RecycleAdapter extends RecyclerView.Adapter {


    ArrayList contactsArray;

    public RecycleAdapter(ArrayList array) {

        this.contactsArray = array;

    }
    @NonNull
    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(@NonNull ViewGroup viewGroup, int i) {
        return null;
    }

    @Override
    public void onBindViewHolder(@NonNull RecyclerView.ViewHolder viewHolder, int i) {

    }

    @Override
    public int getItemCount() {
        return this.contactsArray.size();
    }
}
