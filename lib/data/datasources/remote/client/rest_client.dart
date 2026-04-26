import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_soft_wars/data/datasources/remote/entities/request/change_task_status_body.dart';
import 'package:flutter_soft_wars/data/datasources/remote/entities/response/task_response.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/{email}/tasks")
  Future<TasksContainerResponse> getTasks(@Path('email') String email);

  @POST("/{email}/tasks")
  Future<TasksContainerResponse> createTasks({
    @Path("email") required String email,
    @Body() required List<TaskResponse> tasks,
  });

  @PUT("/{email}/tasks/{taskId}")
  Future<TasksContainerResponse> changeTaskStatus({
    @Path("email") required String email,
    @Path("taskId") required String taskId,
    @Body() required ChangeTaskStatusBody body,
  });

  @DELETE("/{email}/tasks/{taskId}")
  Future<TasksContainerResponse> deleteTask({
    @Path("email") required String email,
    @Path("taskId") required String taskId,
  });
}
