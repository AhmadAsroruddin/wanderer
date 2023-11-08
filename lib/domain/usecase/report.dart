import 'package:wanderer/data/models/report_model.dart';
import 'package:wanderer/domain/repositories/user_repository.dart';

class AddReport {
  UserRepository userRepos;

  AddReport({required this.userRepos});

  Future<void> execute(ReportModel reportModel) async {
    await userRepos.report(reportModel);
  }
}
