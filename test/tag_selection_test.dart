import 'package:flutter_test/flutter_test.dart';

import 'package:chronomap_in_maritime/add_events/principal_model.dart';
import 'package:chronomap_in_maritime/search/search_model.dart';

void main() {
  group('search tag selection', () {
    late SearchModel model;

    setUp(() {
      model = SearchModel();
    });

    test('selects one tag without duplicating its detail id', () {
      model.updateTargetSelection('航海', 10, true);
      model.updateTargetSelection('航海', 10, true);

      expect(model.filtersTarget, ['航海']);
      expect(model.filtersDetailId, [10]);
      expect(model.selectedDetailIds, [10]);
    });

    test('keeps all selected detail ids for OR search', () {
      model.updateTargetSelection('航海', 10, true);
      model.updateTargetSelection('交易', 20, true);

      expect(model.selectedDetailIds, [10, 20]);
    });

    test('removes a deselected tag from every selection list', () {
      model.updateTargetSelection('航海', 10, true);
      model.updateTargetSelection('交易', 20, true);
      model.updateTargetSelection('航海', 10, false);

      expect(model.filtersTarget, ['交易']);
      expect(model.filtersDetailId, [20]);
      expect(model.selectedDetailIds, [20]);
    });
  });

  test('principal entry tag selection also prevents duplicate ids', () {
    final model = PrincipalModel();

    model.updateTargetSelection('航海', 10, true);
    model.updateTargetSelection('航海', 10, true);

    expect(model.filtersTarget, ['航海']);
    expect(model.filtersDetailId, [10]);
    expect(model.selectedDetailIds, [10]);
  });
}
