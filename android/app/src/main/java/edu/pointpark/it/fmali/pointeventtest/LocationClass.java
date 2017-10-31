package edu.pointpark.it.fmali.pointeventtest;

/**
 * Created by Faiz Ali on 4/3/2016.
 */
public class LocationClass {
    double latitude;
    double longitude;

    public LocationClass (double lat, double lng) {
        latitude = lat;
        longitude = lng;
    }

    public LocationClass () {
    }

    public final double getLongitude() {
        return longitude;
    }

    public final double setLng(double lng) {
        this.longitude = lng;
        return lng;
    }

    public final double getLatitude() {
        return latitude;
    }

    public final double setLatitude(double lat) {
        this.latitude = lat;
        return lat;
    }


}
