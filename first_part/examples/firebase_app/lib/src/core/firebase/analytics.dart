import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app/src/core/firebase/constants.dart';

final analyticsObserver = FirebaseAnalyticsObserver(
  analytics: FirebaseAnalytics.instance,
);

void setUserID(String id) {
  if (!firebaseAnalyticsEnabled) return;
  FirebaseAnalytics.instance.setUserId(id: id);
}

void registerEvent(String name, Map<String, Object> attributes) {
  if (!firebaseAnalyticsEnabled) return;
  FirebaseAnalytics.instance.logEvent(
    name: name, // nome_of_event
    parameters: attributes,
  );
}
