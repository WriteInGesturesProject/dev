//Copyright: TeamKrishna (www.teamkrishna.in)
//Author: Kaushik Mazumdar(literaldumb@gmail.com)

package org.godotengine.godot;

//imports
import android.app.Activity;
import android.content.Intent;
import android.speech.tts.TextToSpeech;
import android.speech.tts.TextToSpeech.OnInitListener;
import android.os.Bundle;
import java.util.Locale;

public class GodotTextToSpeech extends Godot.SingletonBase implements OnInitListener {

	Activity m_pActivity;
	Intent speechIntent;
	TextToSpeech myTTS;

	int MY_DATA_CHECK_CODE = 0;

	public void speakText(String speech) {
		myTTS.speak(speech, TextToSpeech.QUEUE_FLUSH, null);
		// tryouts for queue msgs
		// myTTS.speak(speech, TextToSpeech.QUEUE_ADD, null);
	}

	public void fireTTS() {
		speechIntent = new Intent();
		speechIntent.setAction(TextToSpeech.Engine.ACTION_CHECK_TTS_DATA);
		m_pActivity.startActivityForResult(speechIntent, MY_DATA_CHECK_CODE);
	}

	static public Godot.SingletonBase initialize(Activity p_activity) {
		return new GodotTextToSpeech(p_activity);
	}

	public GodotTextToSpeech(Activity p_activity) {
		m_pActivity = p_activity;

		// register class name and functions to bind
		registerClass("GodotTextToSpeech", new String[] { "fireTTS", "speakText" });
	}

	// forwarded callbacks
	protected void onMainActivityResult(int requestCode, int resultCode, Intent data) {
		super.onMainActivityResult(requestCode, resultCode, data);
		if (requestCode == MY_DATA_CHECK_CODE) {
			if (resultCode == TextToSpeech.Engine.CHECK_VOICE_DATA_PASS) {
				myTTS = new TextToSpeech(m_pActivity.getApplicationContext(), this);
			} else {
				Intent localIntent = new Intent();
				localIntent.setAction(TextToSpeech.Engine.ACTION_INSTALL_TTS_DATA);
				m_pActivity.startActivity(localIntent);
			}
		}
	}

	public void onInit(int initStatus) {
		// check for successful instantiation
		if (initStatus == TextToSpeech.SUCCESS) {
			if (myTTS.isLanguageAvailable(Locale.getDefault()) == TextToSpeech.LANG_AVAILABLE)
				myTTS.setLanguage(Locale.getDefault());
		}
	}
}
