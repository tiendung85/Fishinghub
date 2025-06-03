package google;

import com.google.gson.Gson;
import java.io.*;
import java.net.*;
import java.util.*;

public class GoogleUtils {
    public static String GOOGLE_CLIENT_ID;
    public static String GOOGLE_CLIENT_SECRET;
    public static String GOOGLE_REDIRECT_URI;

    static {
        try (InputStream input = GoogleUtils.class.getClassLoader().getResourceAsStream("google_oauth.properties")) {
            Properties prop = new Properties();
            prop.load(input);
            GOOGLE_CLIENT_ID = prop.getProperty("GOOGLE_CLIENT_ID");
            GOOGLE_CLIENT_SECRET = prop.getProperty("GOOGLE_CLIENT_SECRET");
            GOOGLE_REDIRECT_URI = prop.getProperty("GOOGLE_REDIRECT_URI");

            // Debug in ra giá trị 3 biến, nếu sai thì nhìn thấy ngay
            System.out.println("========== GOOGLE OAUTH CONFIG ==========");
            System.out.println("GOOGLE_CLIENT_ID = " + GOOGLE_CLIENT_ID);
            System.out.println("GOOGLE_CLIENT_SECRET = " + GOOGLE_CLIENT_SECRET);
            System.out.println("GOOGLE_REDIRECT_URI = " + GOOGLE_REDIRECT_URI);
            System.out.println("=========================================");
        } catch (Exception e) {
            System.out.println("❌ LỖI ĐỌC FILE google_oauth.properties! File này phải nằm ngay trong Source Packages.");
            e.printStackTrace();
        }
    }

    public static String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";
    public static String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";
    public static String GOOGLE_GRANT_TYPE = "authorization_code";

    public static String getToken(final String code) throws IOException {
        URL url = new URL(GOOGLE_LINK_GET_TOKEN);
        Map<String, Object> params = new LinkedHashMap<>();
        params.put("code", code);
        params.put("client_id", GOOGLE_CLIENT_ID);
        params.put("client_secret", GOOGLE_CLIENT_SECRET);
        params.put("redirect_uri", GOOGLE_REDIRECT_URI);
        params.put("grant_type", GOOGLE_GRANT_TYPE);

        StringBuilder postData = new StringBuilder();
        for (Map.Entry<String, Object> param : params.entrySet()) {
            if (postData.length() != 0) postData.append('&');
            postData.append(URLEncoder.encode(param.getKey(), "UTF-8"));
            postData.append('=');
            postData.append(URLEncoder.encode(String.valueOf(param.getValue()), "UTF-8"));
        }
        byte[] postDataBytes = postData.toString().getBytes("UTF-8");

        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.getOutputStream().write(postDataBytes);

        Reader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        StringBuilder sb = new StringBuilder();
        for (int c; (c = in.read()) >= 0; )
            sb.append((char) c);
        String response = sb.toString();

        Gson gson = new Gson();
        GoogleTokenResponse tokenResponse = gson.fromJson(response, GoogleTokenResponse.class);
        return tokenResponse.access_token;
    }

    public static GoogleUser getUserInfo(final String accessToken) throws IOException {
        URL url = new URL(GOOGLE_LINK_GET_USER_INFO + accessToken);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        Reader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        StringBuilder sb = new StringBuilder();
        for (int c; (c = in.read()) >= 0; )
            sb.append((char) c);
        String response = sb.toString();

        Gson gson = new Gson();
        GoogleUser user = gson.fromJson(response, GoogleUser.class);
        return user;
    }

    private static class GoogleTokenResponse {
        String access_token;
        String expires_in;
        String scope;
        String token_type;
        String id_token;
    }
}