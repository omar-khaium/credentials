part of '../pages/dashboard.dart';

class _AllItem extends StatelessWidget {
  final CredentialEntity credential;
  const _AllItem({
    required this.credential,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: theme.background,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              width: 3,
              color: theme.tertiary,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          child: InkWell(
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PhysicalModel(
                  color: theme.tertiary,
                  child: AspectRatio(
                    aspectRatio: 3,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Center(
                            child: credential.logo != null
                                ? Image.network(
                                    credential.logo!,
                                    fit: BoxFit.contain,
                                    width: 72,
                                    height: 72,
                                  )
                                : Image.asset(
                                    "assets/icon.png",
                                    fit: BoxFit.cover,
                                    width: 48,
                                    height: 48,
                                  ),
                          ),
                        ),
                        if (credential.hitCount != null && credential.hitCount! > 10)
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Icon(
                              Icons.star_rounded,
                              color: theme.secondary,
                              weight: 700,
                              grade: 200,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        credential.url,
                        style: TextStyles.title(context: context, color: theme.primary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        credential.username,
                        style: TextStyles.subTitle(context: context, color: theme.text),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Last updated: ${DateFormat("h:mm a d MMM, yy").format(credential.lastUpdatedAt.toLocal())}",
                        style: TextStyles.caption(context: context, color: theme.text.withAlpha(125)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }
}
