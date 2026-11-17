export 'package:yourcallyourrule/features/labels/widgets/label_selector_widget.dart';
import 'package:yourcallyourrule/features/labels/widgets/label_selector_widget.dart';

class PublicSelectLabel extends LabelSelectorWidget {
  const PublicSelectLabel({
    super.key,
    super.initialLabelId,
    super.initialLabelText,
    super.phoneNumber,
    required super.onLabelIdChanged,
    super.selectLabelService,
    super.themeColor,
  });
}
