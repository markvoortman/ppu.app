package edu.pointpark.it.fmali.pointeventtest;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;


public class MainActivity extends AppCompatActivity {

    public static final String TAG = MainActivity.class.getSimpleName();

    private ListView eventsList;
    ArrayList<ArrayList<String>> eventArrayList = new ArrayList<ArrayList<String>>();
    ArrayList<ArrayList<String>> eventArrayDateList = new ArrayList<ArrayList<String>>();


    public static final String EVENT_INFO = "EVENTINFO";

    public int index;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        OkHttpClient client = new OkHttpClient();

        String url = "http://pointevent.it.pointpark.edu/list_test/test.php";
        eventsList = (ListView) findViewById(R.id.eventsListView);

        String[] items = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"};
        int [] prgmImages={R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher,
                R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher};

        ArrayAdapter<String> eventsAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, items);
        //eventsList.setAdapter(new CustomAdapter(this, items, prgmImages));
        eventsList.setAdapter(eventsAdapter);

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
                    getCurrentEvents(jsonData);
                    //eventInfo(jsonData);
                    Log.v(TAG, jsonData);


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
    }

    private void getCurrentEvents(final String jsonData) throws JSONException {

        JSONArray data = new JSONArray(jsonData);
        int length = data.length();
        int i;
        for (i = 0; i < length; i++) {
            JSONObject dataObj = data.getJSONObject(i);
            //String temp = dataObj.getString("event");
            //dataArray[i] = temp;

            ArrayList<String> tempArray = new ArrayList<String>();
            ArrayList<String> dateArray = new ArrayList<String>();

            tempArray.add(dataObj.getString("event"));
            tempArray.add(dataObj.getString("date"));
            //dateArray.add(dataObj.getString("date"));
            tempArray.add(dataObj.getString("time"));
            tempArray.add(dataObj.getString("building"));
            tempArray.add(dataObj.getString("offlocation"));
            tempArray.add(dataObj.getString("address1"));
            tempArray.add(dataObj.getString("address2"));
            tempArray.add(dataObj.getString("city"));
            tempArray.add(dataObj.getString("zip"));
            tempArray.add(dataObj.getString("description"));

            //tempArray.add(dataObj.getString("address1") + "" + dataObj.getString("address2")+ "" + dataObj.getString("city") + ", PA " + dataObj.getString("zip"));

            eventArrayList.add(tempArray);
        }

        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                //ArrayAdapter<String> eventsAdapter = new ArrayAdapter<String>(MainActivity.this, android.R.layout.simple_list_item_1, getEventNames());
                int [] prgmImages={R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher,
                        R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher,
                        R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher};
                int [] arrowImages = {R.mipmap.arrow, R.mipmap.arrow, R.mipmap.arrow, R.mipmap.arrow,R.mipmap.arrow, R.mipmap.arrow,R.mipmap.arrow, R.mipmap.arrow,R.mipmap.arrow, R.mipmap.arrow,R.mipmap.arrow, R.mipmap.arrow,
                        R.mipmap.arrow, R.mipmap.arrow,R.mipmap.arrow, R.mipmap.arrow,R.mipmap.arrow, R.mipmap.arrow,R.mipmap.arrow, R.mipmap.arrow,R.mipmap.arrow, R.mipmap.arrow,R.mipmap.arrow, R.mipmap.arrow,
                        R.mipmap.arrow, R.mipmap.arrow,R.mipmap.arrow, R.mipmap.arrow,R.mipmap.arrow, R.mipmap.arrow,R.mipmap.arrow, R.mipmap.arrow,R.mipmap.arrow, R.mipmap.arrow,R.mipmap.arrow, R.mipmap.arrow};
                eventsList.setAdapter(new CustomAdapter(MainActivity.this, getEventNames(), prgmImages, arrowImages));
                //eventsList.setAdapter(eventsAdapter);
            }
        });

        eventsList.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            public void onItemClick(AdapterView<?> av, View view, int position, long id) {
                //What is the difference between ID and position?
                Log.i(TAG, "Position:" + position);
                Log.i(TAG, "ID:" + id);

                index = position;
                Toast.makeText(MainActivity.this, "Index= " + index, Toast.LENGTH_SHORT).show();
                //String indexString = Integer.toString(index);

                ArrayList<String> selectedEvent = eventArrayList.get(index);

                Intent intent = new Intent(MainActivity.this, EventActivity.class);
                intent.putStringArrayListExtra(EVENT_INFO, selectedEvent);
                //intent.putExtra(EVENT_INFO, selectedEvent);
                startActivity(intent);

                //intent.putParcelableArrayListExtra("key", ArrayList<T extends Parcelable> selectedEvent);
                //intent.putExtra(EVENT, eventString);
            }
        });

    }

    private ArrayList<String> getEventNames() {
        ArrayList<String> currentEvent = new ArrayList<String>();
        ArrayList<String> allEvents = new ArrayList<String>();
        final int max = eventArrayList.size();
        for (int i = 0; i < max; i++) {
            currentEvent = eventArrayList.get(i);
            allEvents.add(currentEvent.get(0)); //index of an event
            //Log.e(TAG, "Event index: " + i + "Event name: " + currentEvent.get(0));
        }
        return allEvents;
    }
}
