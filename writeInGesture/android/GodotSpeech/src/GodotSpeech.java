//Kaushik Mazumdar

package org.godotengine.godot;

//imports
import android.app.Activity;
import android.content.Intent;
import android.content.Context;
import android.speech.RecognizerIntent;
import java.util.ArrayList;

public class GodotSpeech extends Godot.SingletonBase {

	private static final int REQUEST_OK = 1;
	private static final int RESULT_OK = -1;
	Activity m_pActivity;
	Intent recognizerIntent;
	String m_pWords = "";

	public String getWords() {
		return m_pWords;
	}

	public void doListen() {
		recognizerIntent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
		// recognizerIntent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, "en-US");
		recognizerIntent.putExtra("android.speech.extra.EXTRA_ADDITIONAL_LANGUAGES", new String[] { "fr" });
		m_pActivity.startActivityForResult(recognizerIntent, REQUEST_OK);
	}

	static public Godot.SingletonBase initialize(Activity p_activity) {
		return new GodotSpeech(p_activity);
	}

	public GodotSpeech(Activity p_activity) {
		m_pActivity = p_activity;

		// register class name and functions to bind
		registerClass("GodotSpeech", new String[] { "doListen", "getWords" });
	}

	// forwarded callbacks
	protected void onMainActivityResult(int requestCode, int resultCode, Intent data) {
		super.onMainActivityResult(requestCode, resultCode, data);
		if (requestCode == REQUEST_OK && resultCode == RESULT_OK) {
			ArrayList<String> thingsYouSaid = data.getStringArrayListExtra(RecognizerIntent.EXTRA_RESULTS);
			m_pWords = thingsYouSaid.get(0);
		}
	}
}
