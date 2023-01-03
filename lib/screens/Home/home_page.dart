import 'package:amazon_admin/constants/constants.dart';
import 'package:amazon_admin/constants/kcolors.dart';
import 'package:amazon_admin/providers/product_provider.dart';
import 'package:amazon_admin/providers/user_provider.dart';
import 'package:amazon_admin/widgets/app_button.dart';
import 'package:amazon_admin/widgets/app_text.dart';
import 'package:amazon_admin/widgets/app_text_form_field.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routename = 'admin-home-page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: KColors.appBarGradient,
          ),
        ),
        toolbarHeight: 100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            SvgPicture.asset(
              'assets/icons/amazon-icon.svg',
              height: 24,
            ),
            const SizedBox(height: 10.0),
            const SizedBox(
              height: 42,
              child: AppTextFormField(
                hintText: "Search",
                contentPadding: EdgeInsets.only(bottom: 10.0),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80,
              child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemExtent: 75,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // GlobalVariables.categoryImages[index]['title']!;
                      // Navigator.pushNamed(context, SearchPage.routename);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              categories[index]['image']!,
                              fit: BoxFit.cover,
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                        AppText(
                          categories[index]['title']!,
                          fontSize: 12,
                          maxLines: 2,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            CarouselSlider(
              items: Constants.images.map(
                (i) {
                  return Builder(
                    builder: (context) => ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        i,
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 400),
                height: 200,
              ),
            ),
            ChangeNotifierProvider<ProductProvider>(
              create: (_) => ProductProvider()..getProductsList(context),
              child: Consumer<ProductProvider>(
                builder: (context, prodcutProvider, child) {
                  if (prodcutProvider.productlists != null &&
                      prodcutProvider.productlists!.isEmpty) {
                    return const SizedBox(
                      height: 100,
                      child: Center(
                        child: AppText(
                          'No product added yet',
                          fontSize: 18,
                          color: Colors.black38,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }

                  return GridView.builder(
                    itemCount: prodcutProvider.productlists?.length ?? 0,
                    padding: const EdgeInsets.all(10),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final product = prodcutProvider.productlists![index];
                      final cart = userProvider.user.cart;

                      bool isProductInCart = cart.any(
                        (item) => item.product!.id == product.id,
                      );

                      return Card(
                        color: const Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF7F7F7),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: CarouselSlider.builder(
                                    itemCount: product.images.length,
                                    itemBuilder: (_, index, __) {
                                      return Image.network(
                                        product.images[index],
                                        fit: BoxFit.contain,
                                      );
                                    },
                                    options: CarouselOptions(
                                      viewportFraction: 1,
                                      autoPlay: true,
                                      autoPlayAnimationDuration: const Duration(
                                        milliseconds: 200,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, left: 8.0),
                                child: AppText(
                                  product.name,
                                  fontSize: 18,
                                  color: Colors.black,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5.0, left: 8.0),
                                child: AppText(
                                  'Rs. ${product.price.toInt()}',
                                  maxLines: 1,
                                  color: KColors.selectedNavBarColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  ...List.generate(
                                    5,
                                    (index) => const Icon(
                                      Icons.star,
                                      size: 20,
                                      color: KColors.secondaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const AppText("4.5")
                                ],
                              ),
                              AppButton(
                                onTap: () {
                                  if (isProductInCart) return;
                                  userProvider.addToCart(context, product.id!);
                                },
                                height: 35,
                                child: Row(
                                  children: [
                                    AppText(
                                      isProductInCart ? "Added" : 'Add to cart',
                                      color: Colors.white,
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.shopping_cart,
                                      size: 20,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
