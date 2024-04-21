part of '../pages/dashboard.dart';

class _PopularItem extends StatelessWidget {
  final CredentialEntity credential;
  const _PopularItem({
    required this.credential,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: theme.background,
                surfaceTintColor: theme.background,
                contentPadding: EdgeInsets.zero,
                content: BlocProvider(
                  create: (_) => sl<HitCredentialBloc>(),
                  child: ViewCredentialWidget(credential: credential),
                ),
              ),
            );
          },
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: theme.background,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                width: 3,
                color: theme.accent.shade50,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            child: Row(
              children: [
                PhysicalModel(
                  color: theme.accent.shade50,
                  child: SizedBox(
                    width: 54,
                    height: 54,
                    child: credential.logo != null
                        ? Image.network(
                            credential.logo!,
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Image.asset(
                              "assets/icon.png",
                              fit: BoxFit.cover,
                              width: 24,
                              height: 24,
                            ),
                          ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              credential.url,
                              style: TextStyles.subTitle(context: context, color: theme.link),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              credential.username,
                              style: TextStyles.caption(context: context, color: theme.text),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
