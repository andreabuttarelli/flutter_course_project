abstract class GetUserIDResponse {}

class GetUserIDFailedResponse extends GetUserIDResponse {
  final Exception exception;

  GetUserIDFailedResponse(this.exception);
}

class GetUserIDSuccessResponse extends GetUserIDResponse {
  final String userID;

  GetUserIDSuccessResponse(this.userID);
}
