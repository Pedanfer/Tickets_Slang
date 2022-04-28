import 'package:exploration_planner/src/views/userRegister.dart';
import 'package:flutter/material.dart';

import '../functions/utilidades.dart';
import '../utils/widgets.dart';

var dimension;
bool isVisibleRegister = false;
List<String> terms = [
  'Slang (producto de Slang Innovations SL) informa a los usuarios que respeta la legislación vigente en materia de protección de datos personales, la privacidad de los usuarios y el secreto y seguridad de los datos personales, adoptando para ello las medidas técnicas y organizativas necesarias para evitar la pérdida, mal uso, alteración, acceso no autorizado y robo de los datos personales facilitados, habida cuenta del estado de la tecnología, la naturaleza de los datos y los riesgos a los que están expuestos.',
  'Los servicios, acceso a los contenidos y oferta de productos de esta web está exclusivamente dirigida a mayores de 18 años, por lo que cualquier persona que entregue sus datos personales, manifiesta tener dicha edad, quedando prohibido el uso de www.slang.digital y la entrega de datos personales a personas menores de edad.',
  'Slang tratará los datos de conformidad con los principios de calidad exigidos por la Ley Orgánica 15/1999, de 13 de diciembre de Protección de Datos (LOPD), de forma confidencial y con las medidas de seguridad exigidas por el Real Decreto 1720/2007, de 21 de diciembre, por el que se aprueba el Reglamento de desarrollo de la Ley Orgánica 15/1999, de 13 de diciembre, de protección de datos de carácter personal.',
  'Los datos de carácter personal que se faciliten en la Web, quedarán registrados en un fichero de Slang debidamente declarado e inscrito en el Registro General de la Agencia Española de Protección de Datos, con la finalidad de llevar a cabo la prestación de los servicios ofrecidos, así como para enviar por cualquier medio, incluido el correo electrónico, ofertas de productos y servicios de nuestra empresa, mejorar la relación comercial y gestionar las peticiones realizadas por nuestros Clientes.',
  'Así mismo la aceptación de esta Política de Privacidad, implica el consentimiento inequívoco del usuario para la cesión de sus datos personales a Slang Innovations S.L con domicilio en C/Campus Universitario 7, 30100, Murcia, España , titular de la marca Slang, todo ello con la finalidad de poder ofrecerle servicios o productos de valor añadido relacionados con la marca o la propia empresa. En todo caso el usuario podrá ejercitar su derecho de oposición, de acuerdo a lo establecido en la cláusula 7ª de esta Política de Privacidad.',
  'El simple hecho de enviar un usuario sus datos de carácter personal a Slang supondrá el consentimiento para su incorporación al fichero y su tratamiento.',
  'El usuario podrá revocar el consentimiento prestado, sin que tenga efectos retroactivos, y ejercer los derechos de acceso, rectificación, cancelación y oposición dirigiéndose mediante carta adjuntando su DNI u otro documento identificativo a Slang Innovations S.L. (C/Campus Universitario 7, 30100, Murcia).',
  'El usuario garantiza que los datos personales facilitados a Slang son veraces y se hace responsable de comunicar cualquier modificación de los mismos para que, en todo momento respondan a su situación actual.',
  'Si tienes cualquier duda o comentario sobre la forma en que Slang utiliza los datos de sus usuarios, escríbenos a info@slanginnovations.com'
];

class TermsService extends StatefulWidget {
  @override
  State<TermsService> createState() => _TermsServiceState();
}

class _TermsServiceState extends State<TermsService> {
  @override
  Widget build(BuildContext context) {
    dimension = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xff011A58),
              Color(0xffECEEF3),
            ],
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: dimension.height * 0.02),
              Visibility(child: Image.asset('lib/assets/Logo_slang_horiz.png', width: dimension.width * 0.55)),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white,
                ),
                height: dimension.height * 0.7,
                margin: EdgeInsets.symmetric(horizontal: dimension.width * 0.05, vertical: dimension.width * 0.05),
                padding: EdgeInsets.symmetric(horizontal: dimension.width * 0.05, vertical: dimension.height * 0.025),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleWithUnderline(text: 'Política de privacidad', fontSize: 24, spaceLength: 10),
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: terms.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return new Text(
                            (index + 1).toString() + ". " + terms[index],
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: dimension.height * 0.04);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: CustomButton(
                  text: 'Volver',
                  width: dimension.width * 0.9,
                  height: dimension.height * 0.065,
                  onPressed: () => {changePageFade(UserRegister(), context)},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
