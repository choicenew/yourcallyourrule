import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'src/label_generator.dart';

Builder labelBuilder(BuilderOptions options) =>
    SharedPartBuilder([LabelGenerator()], 'label_gen');
