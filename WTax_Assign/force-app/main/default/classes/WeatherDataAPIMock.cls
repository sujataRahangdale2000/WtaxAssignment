global class WeatherDataAPIMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setBody(
            '{"timezone":"Asia/Kolkata",' +
            '"hourly":{' +
            '"time":["2026-05-31T00:00","2026-05-31T01:00"],' +
            '"temperature_2m":[28.5,27.8]' +
            '}}'
        );
        return res;
    }
}