import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:organaki_app/bloc/bloc_edit_producer/edit_producer_bloc.dart';
import 'package:organaki_app/core/colors_app.dart';
import 'package:organaki_app/core/extensions.dart';
import 'package:organaki_app/models/producer.dart';
import 'package:organaki_app/models/singleton_location_user.dart';
import 'package:organaki_app/models/singleton_user.dart';
import 'package:organaki_app/modules/home/pages/home_orders_page.dart';

class ProducerEditPage extends StatefulWidget {
  const ProducerEditPage({super.key, required this.producerUser});

  final Producer producerUser;

  @override
  State<ProducerEditPage> createState() => _ProducerEditPageState();
}

class _ProducerEditPageState extends State<ProducerEditPage> {
  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.producerUser.name);
    _emailNameController =
        TextEditingController(text: widget.producerUser.email);
    _descrpitionController =
        TextEditingController(text: widget.producerUser.short_description);
    _contactController =
        TextEditingController(text: widget.producerUser.contact);
    _openingHoursController =
        TextEditingController(text: widget.producerUser.opening_hours);
    _addressController =
        TextEditingController(text: widget.producerUser.address);
    if (widget.producerUser.lat != null && widget.producerUser.lat != null) {
      LatLongUser = LatLng(widget.producerUser.lat!, widget.producerUser.lng!);
    }
  }

  //final Producer producer;
  late TextEditingController _fullNameController = TextEditingController();
  late TextEditingController _emailNameController = TextEditingController();
  late TextEditingController _descrpitionController = TextEditingController();
  late TextEditingController _contactController = TextEditingController();
  late TextEditingController _openingHoursController = TextEditingController();
  late TextEditingController _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  LatLng? LatLongUser;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailNameController.dispose();
    _descrpitionController.dispose();
    _contactController.dispose();
    _openingHoursController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Widget buildFormField(String nameField, String hintTextField,
      TextEditingController controllerField,
      [TextInputType? type]) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 28, bottom: 5, left: 40),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              height: 25.0,
              child: Text(
                nameField,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: ColorApp.dark1,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Abhaya Libre',
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 350.0,
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: TextFormField(
            controller: controllerField,
            keyboardType: type,
            style: TextStyle(
              color: ColorApp.dark1,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              fontFamily: 'Abhaya Libre',
            ),
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Icon(
                  Icons.edit,
                  color: ColorApp.blue4,
                ),
              ),
              contentPadding: const EdgeInsets.only(left: 15),
              filled: true,
              fillColor: ColorApp.white4,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(14.0),
                ),
                borderSide: BorderSide.none,
              ),
              hintText: hintTextField,
              hintStyle: TextStyle(
                color: ColorApp.grey3,
                fontSize: 17,
                fontWeight: FontWeight.w500,
                fontFamily: 'Abhaya Libre',
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left,
            size: 35,
            weight: 10,
          ),
        ),
        title: Text(
          "Editar",
          style: TextStyle(
            color: ColorApp.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Abhaya Libre',
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: ColorApp.grey1,
            height: 1,
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //nesses campos, pensei em colocar os nomes de antes da edicao no hintText
              SizedBox(
                width: 124.0,
                height: 124.0,
                child: Stack(
                  children: [
                    Align(
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 25),
                        width: 124.0,
                        height: 124.0,
                        decoration: BoxDecoration(
                          color: ColorApp.blue4,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          size: 62.0,
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: const EdgeInsets.only(top: 25),
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: ColorApp.dark1,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          size: 20.0,
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buildFormField(
                "Nome",
                widget.producerUser.name,
                _fullNameController,
              ),
              buildFormField(
                "E-mail",
                widget.producerUser.email,
                _emailNameController,
              ),
              buildFormField(
                "Descrição",
                widget.producerUser.short_description,
                _descrpitionController,
              ),
              buildFormField(
                "Número para contato",
                widget.producerUser.contact ?? "",
                _contactController,
              ),
              buildFormField(
                "Horas abertas",
                widget.producerUser.opening_hours ?? "",
                _openingHoursController,
              ),

              Container(
                margin: const EdgeInsets.only(top: 28, right: 150, bottom: 5),
                child: SizedBox(
                  width: 170.0,
                  height: 25.0,
                  child: Text(
                    "Tags",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: ColorApp.dark1,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Abhaya Libre',
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 25,
                  left: 10,
                  right: 10,
                ),
                child: TagsFilter(
                  listTags: widget.producerUser.tags,
                  startTagsSelecteds: (listTags) {
                    widget.producerUser.tags = listTags;
                  },
                ),
              ),
              15.sizeH,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: SizedBox(
                      child: Text(
                        "Marque no mapa a sua localização",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: ColorApp.dark1,
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Abhaya Libre',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 300,
                margin: const EdgeInsets.only(top: 20),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: 260,
                        child: FlutterMap(
                          mapController: MapController(),
                          options: MapOptions(
                            center: SingletonLocationUser().userLocation,
                            zoom: 14,
                            onTap: (tapPosition, point) {
                              setState(() {
                                LatLongUser =
                                    LatLng(point.latitude, point.longitude);
                              });
                            },
                          ),
                          nonRotatedChildren: const [],
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            ),
                            MarkerLayer(
                              markers: [
                                if (LatLongUser != null)
                                  Marker(
                                    width: 20,
                                    height: 20,
                                    point: LatLongUser!,
                                    builder: (ctx) => Container(
                                      decoration: BoxDecoration(
                                          color: ColorApp.blue3,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: const Center(
                                        child: Icon(
                                          Icons.my_location,
                                          size: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Marker(
                                    point: SingletonLocationUser().userLocation!,
                                    builder: (context) => Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        color: ColorApp.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          decoration: BoxDecoration(
                            color: ColorApp.blue3,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Clique no mapa para\n salvar a localização",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Abhaya Libre',
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buildFormField(
                "Informação adicional",
                widget.producerUser.address ?? "",
                _addressController,
              ),
              Container(
                margin: const EdgeInsets.all(30),
                width: 348,
                height: 58,
                child: FilledButton(
                  onPressed: () {
                    var updatedProducer = Producer(
                        id: widget.producerUser.id,
                        name: _fullNameController.text,
                        email: _emailNameController.text,
                        visible_producer: false, // no matter the value
                        short_description: _descrpitionController.text,
                        address: _addressController.text,
                        contact: _contactController.text,
                        opening_hours: _openingHoursController.text,
                        tags: widget.producerUser.tags,
                        lat: LatLongUser?.latitude,
                        lng: LatLongUser?.longitude);
                    BlocProvider.of<EditProducerBloc>(context).add(
                        EditProducerStart(
                            updatedProducer, SingletonUser().userAuth!.token!));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                      ColorApp.blue3,
                    ),
                    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  child: BlocConsumer<EditProducerBloc, EditProducerState>(
                    listener: (context, state) {
                      if (state is EditProducerFailure) {
                        //TODO apply flushbar here
                      }
                      if (state is EditProducerSuccess) {
                        //TODO apply flushbar here
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      if (state is EditProducerProgress) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        ));
                      }
                      return Text(
                        "Salvar alterações",
                        style: TextStyle(
                          color: ColorApp.white1,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Abhaya Libre',
                          fontSize: 18,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
