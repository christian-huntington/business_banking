import 'package:business_banking/locator.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:flutter/widgets.dart';
import 'package:mockito/mockito.dart';

class MockRepositoryScope extends Mock implements RepositoryScope {
  // @override
  // Function(dynamic) get subscription => subscription;

  MockRepositoryScope(subcription);
}

class MockExampleLocator extends Mock implements ExampleLocator {
  @override
  MockRepository get repository => MockRepository();
}

class MockRepository extends Mock implements Repository {}

class MockBuildContext extends Mock implements BuildContext {}

class DummyFunctions {
  dynamic voidCallBack(dynamic v) {}
}

class MockDummyFunctions extends Mock implements DummyFunctions {}