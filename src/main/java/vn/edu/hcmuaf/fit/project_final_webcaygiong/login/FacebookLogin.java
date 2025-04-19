package vn.edu.hcmuaf.fit.project_final_webcaygiong.login;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Request;  // Đúng import cho Request
import org.apache.http.client.fluent.Form;     // Đúng import cho Form
import com.google.gson.JsonObject;             // Đúng import cho JsonObject
import com.google.gson.Gson;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;
import java.util.Date;

public class FacebookLogin {
    public static String getToken(String code) throws ClientProtocolException, IOException {
        String response = Request.Post(IConstant.FACEBOOK_LINK_GET_TOKEN)
                .bodyForm(
                        Form.form()

                                .add("client_id", IConstant.FACEBOOK_CLIENT_ID)

                                .add("client_secret", IConstant.FACEBOOK_CLIENT_SECRET)

                                .add("redirect_uri", IConstant.FACEBOOK_REDIRECT_URI)

                                .add("code", code)

                                .build()

                )
                .execute().returnContent().asString();
        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }

        public static User getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
            String link = IConstant.FACEBOOK_LINK_GET_USER_INFO + accessToken;
            String response = Request.Get(link).execute().returnContent().asString();

            // Parse JSON trực tiếp thành User
            JsonObject jsonObject = new Gson().fromJson(response, JsonObject.class);

            User user = new User();
            user.setFacebookId(jsonObject.get("id").getAsString());
            user.setName(jsonObject.get("name").getAsString());

            if (jsonObject.has("email")) {
                user.setEmail(jsonObject.get("email").getAsString());
            }

            if (jsonObject.has("picture")) {
                JsonObject picture = jsonObject.getAsJsonObject("picture");
                JsonObject data = picture.getAsJsonObject("data");
                user.setAvatar(data.get("url").getAsString());
            }

            user.setCreateAt(new Date());
            user.setUpdateAt(new Date());

            return user;
        }
    }