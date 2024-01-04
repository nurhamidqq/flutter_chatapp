import 'package:flutter/material.dart';
import 'package:flutter_chatapp/domain/entities/user.dart';
import 'package:flutter_chatapp/presentation/extentions/build_context_extention.dart';
import 'package:flutter_chatapp/presentation/misc/constants.dart';
import 'package:flutter_chatapp/presentation/misc/methods.dart';
import 'package:flutter_chatapp/presentation/pages/home_page/components/my_app_bar.dart';
import 'package:flutter_chatapp/presentation/providers/router/router_provider.dart';
import 'package:flutter_chatapp/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (previous != null && next is AsyncData && next.value == null) {
          ref.read(routerProvider).goNamed('login');
        } else if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        elevation: 0,
        title: MyAppBar(context: context),
      ),
      drawer: Drawer(
        backgroundColor: secondary,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: CircleAvatar(
                          backgroundColor: primary,
                          maxRadius: 40,
                          child: Text(
                            ref.read(userDataProvider).valueOrNull?.name[0] ??
                                '-',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      verticalSpace(5),
                      Text(
                        ref.read(userDataProvider).valueOrNull?.name ?? '-',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      )
                    ],
                  )
                ],
              ),
            ),
            TextButton(
              onPressed: () => ref.read(userDataProvider.notifier).logout(),
              child: const Text(
                'Sign Out',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            verticalSpace(20),
          ],
        ),
      ),
      body: StreamBuilder<List<User>?>(
        stream: ref.read(userDataProvider.notifier).getListUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            if (data != null) {
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  height: 0,
                  color: primary.withOpacity(0.1),
                ),
                itemBuilder: (context, i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => ref.watch(routerProvider).pushNamed('chat',
                            extra: (
                              ref.read(userDataProvider).valueOrNull,
                              data[i]
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: secondary,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    padding: const EdgeInsets.all(2),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      padding: const EdgeInsets.all(2),
                                      child: CircleAvatar(
                                        backgroundColor: randomColorPrimary(),
                                        child: Text(
                                          data[i].name[0],
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  horizontalSpace(16),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width -
                                        32 -
                                        40 -
                                        60,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data[i].name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text(
                                          'chat terakhir chat terakhir chat terakhir chat terakhir ',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 40,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      '10:00',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: grey,
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/images/check.png',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                itemCount: snapshot.data?.length ?? 0,
              );
            }
            return const Center(
              child: Text('No User'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: primary,
            ),
          );
        },
      ),
    );
  }
}
