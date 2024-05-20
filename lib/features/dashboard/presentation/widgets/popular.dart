part of '../pages/dashboard.dart';

class _Popular extends StatelessWidget {
  const _Popular();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return BlocBuilder<CredentialBloc, CredentialState>(
          builder: (_, state) {
            if (state is CredentialDone && state.popular.isNotEmpty) {
              return ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                clipBehavior: Clip.none,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  const SizedBox(height: 24),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 24),
                      Icon(
                        Icons.star_rounded,
                        color: theme.secondary,
                        weight: 700,
                        grade: 200,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "Most Popular Credentials",
                        style: TextStyles.body(
                          context: context,
                          color: theme.secondary,
                        ).copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  MasonryGridView.count(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    padding: EdgeInsets.all(24),
                    clipBehavior: Clip.none,
                    itemCount: state.popular.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final credential = state.popular[index];
                      return _PopularItem(credential: credential);
                    },
                  ),
                  const SizedBox(height: 12),
                  Divider(),
                  const SizedBox(height: 12),
                ],
              );
            }
            return Container();
          },
        );
      },
    );
  }
}
