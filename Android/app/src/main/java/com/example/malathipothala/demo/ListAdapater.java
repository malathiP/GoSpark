package com.example.malathipothala.demo;

import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.support.v4.app.NotificationCompat;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.zip.Inflater;

import static android.content.Context.NOTIFICATION_SERVICE;
import static android.support.v4.content.ContextCompat.getSystemService;

public class ListAdapater extends BaseAdapter {

    interface ListInterface {

        public void selectRow(int index);


    }
    ArrayList<String> listArray;
    Context context;
    ListInterface listInterface;


    public ListAdapater(ArrayList categoriesArray, Context context) {

        System.out.println("Array List : "+categoriesArray);
        this.listArray = categoriesArray;
        context = context;
    }

    /**
     *
     * ListView Adapter Methods
     */
    @Override
    public int getCount() {
        return this.listArray.size();
    }

    @Override
    public Object getItem(int position) {
        return null;
    }

    @Override
    public long getItemId(int position) {
        return 0;
    }

    @Override
    public View getView(final int position, View convertView, ViewGroup parent) {
        LayoutInflater inflat = LayoutInflater.from(parent.getContext());
        final View view = inflat.inflate(R.layout.rowlayout,parent,false);
        TextView textView  = view.findViewById(R.id.nameLabel);
        textView.setText(this.listArray.get(position));


        return view;
    }
}
