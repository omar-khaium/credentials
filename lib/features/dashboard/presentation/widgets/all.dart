part of '../pages/dashboard.dart';

class _All extends StatelessWidget {
  const _All();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CredentialBloc, CredentialState>(
      builder: (_, state) {
        if (state is CredentialDone) {
          return MasonryGridView.count(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            crossAxisCount: 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            padding: EdgeInsets.all(24),
            clipBehavior: Clip.none,
            itemCount: state.credentials.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              final credential = state.credentials[index];
              return _AllItem(credential: credential);
            },
          );
        }
        return Container();
      },
    );
  }
}
