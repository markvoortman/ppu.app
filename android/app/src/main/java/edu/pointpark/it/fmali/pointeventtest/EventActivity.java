package edu.pointpark.it.fmali.pointeventtest;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.GoogleMapOptions;
import com.google.android.gms.maps.MapFragment;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;


public class EventActivity extends AppCompatActivity implements OnMapReadyCallback {

    public static final String TAG = EventActivity.class.getSimpleName();
    private TextView eventName;
    private TextView eventDate;
    private TextView eventDesc;
    private TextView eventAddress;
    private TextView eventAddress2;


    String url;
    public String event;
    public String date;
    public String time;
    public String building;
    public String offlocation;
    public String address1;
    public String address2;
    public String city;
    public String zip;
    public String address;
    public String description;

    String getLatLong = "";
    String title = "Event Location";

    LocationClass locationLatLng;
    double lat;
    double lng;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_event);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        ArrayList<String> eventInfo = getIntent().getExtras().getStringArrayList("EVENTINFO");

        event = eventInfo.get(0);
        date = eventInfo.get(1);
        time = eventInfo.get(2);
        building = eventInfo.get(3);
        offlocation = eventInfo.get(4);
        address1 = eventInfo.get(5);
        address2 = eventInfo.get(6);
        city = eventInfo.get(7);
        zip = eventInfo.get(8);
        description = eventInfo.get(9);


        address = address1 + " " + address2 + " " + city + ", PA " + zip;

        eventName = (TextView) findViewById(R.id.eventNameTextView);
        eventDate = (TextView) findViewById(R.id.dateTextView);
        eventDesc = (TextView) findViewById(R.id.descTextView);
        eventAddress = (TextView) findViewById(R.id.addressTextView);
        eventAddress2 = (TextView) findViewById(R.id.addressTextView);


        eventName.setText(event);
        eventDate.setText(date);
        eventDesc.setText(description);
        eventAddress.setText(address1 + " " + address2);
        eventAddress2.setText(city + ", PA" + " " + zip);

        MapFragment mapFragment = (MapFragment) getFragmentManager()
                .findFragmentById(R.id.mapFragment);

        mapFragment.getMapAsync(this);
        //GoogleMapOptions options = new GoogleMapOptions().liteMode(true);

        //Log.e(TAG, eventInfo.get(0));
        //Log.e(TAG, eventInfo.get(1));
        //Log.e(TAG, building);
        //Log.e(TAG, eventInfo.get(3));


        Toast.makeText(EventActivity.this, "You clicked " + TAG, Toast.LENGTH_SHORT).show();

        url = "http://maps.googleapis.com/maps/api/geocode/json?address=";

        if (offlocation.equals("no")) {
            if (building.equals("westpenn")) {
                getLatLong = "west penn bldg pittsburgh, pa 15222";
                title = "West Penn";
            }
            if (building.equals("park")) {
                getLatLong = "Village Park, Wood Street, Pittsburgh, PA 15222";
                title = "Village Park";
            }
            if (building.equals("academic")) {
                getLatLong = "Academic Hall, Pittsburgh, PA 15222";
                title = "Academic Hall";
            }
            url = url + getLatLong;
        }
        if (offlocation.equals("yes")) {
            url = url + address;
            title = "Off Campus Location";
            Log.v(TAG, url);
        }

        OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
                .url(url)
                .build();

        Call call = client.newCall(request);
        call.enqueue(new Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        //toggleRefresh();
                    }

                });
                //alertUserAboutError();

            }

            @Override
            public void onResponse(Call call, Response response) throws IOException {
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        //toggleRefresh();
                    }

                });

                try {
                    String jsonData = response.body().string();
                    locationLatLng = new LocationClass();
                    locationLatLng = getLatLong(jsonData);
                    lat = locationLatLng.getLatitude();
                    lng = locationLatLng.getLongitude();
                    if (response.isSuccessful()) {
                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                //
                       }
                        });
                    } else {
                        //alertUserAboutError();
                    }
                } catch (IOException e) {
                    Log.e(TAG, "Exception caught: ", e);
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        });
    }



    @Override
    public void onMapReady(GoogleMap mapFragment) {
        /*OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
                .url(url)
                .build();

        Call call = client.newCall(request);
        call.enqueue(new Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        //toggleRefresh();
                    }

                });
                //alertUserAboutError();

            }

            @Override
            public void onResponse(Call call, Response response) throws IOException {
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        //toggleRefresh();
                    }

                });

                try {
                    String jsonData = response.body().string();
                    if (onoff = true) {
                        locationLatLng = new LocationClass();
                        locationLatLng = getLatLong(jsonData);
                        lat = locationLatLng.getLatitude();
                        lng = locationLatLng.getLongitude();

                        //Log.v(TAG, jsonData);
                    } else {
                        locationLatLng = getLatLong(jsonData);
                        lat = locationLatLng.getLatitude();
                        lng = locationLatLng.getLongitude();
                        Log.v(TAG, "lat: " + lat);
                        Log.v(TAG, "lng: " + lng);
                    }

                    if (response.isSuccessful()) {
                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                //updateDisplay();
                            }
                        });
                    } else {
                        //alertUserAboutError();
                    }
                } catch (IOException e) {
                    Log.e(TAG, "Exception caught: ", e);
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        });
*/

        LatLng eventLocation = new LatLng(lat, lng);
        //map.setMyLocationEnabled(true);
        mapFragment.moveCamera(CameraUpdateFactory.newLatLngZoom(eventLocation, 15));

        Marker info = mapFragment.addMarker(new MarkerOptions()
                .title(title)
                //.snippet("The most populous city in Australia.")
                .position(eventLocation));
        info.showInfoWindow();

        return;
    }

    private LocationClass getLatLong(String jsonData) throws JSONException {
        JSONObject results = new JSONObject(jsonData);
        JSONObject location = results.getJSONArray("results").getJSONObject(0).getJSONObject("geometry").getJSONObject("location");
        //Log.e(TAG, "results: " + results);

        double latitude = location.getDouble("lat");
        double longitude = location.getDouble("lng");

        LocationClass locationLatLng = new LocationClass(latitude, longitude);
        Log.e(TAG, "latitude: " + locationLatLng.getLatitude());
        Log.e(TAG, "longitude: " + locationLatLng.getLongitude());

        return locationLatLng;
    }
}
