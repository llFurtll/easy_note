import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemListConfiguracaoEditViewWidget extends StatelessWidget {
  String identificador;
  int valor;

  ItemListConfiguracaoEditViewWidget({required this.identificador, required this.valor, super.key});


  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildDescription(context),
            _buildSwitch(context)
          ]
        )
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 5.0,
        children: [
          Text(
            _getDescription(identificador),
            style: const TextStyle(
              fontWeight: FontWeight.bold
            ),
            maxLines: null,
          ),
          ..._getIconConfig(identificador).map(
            (widget) => widget.runtimeType == IconData ? Icon(widget) : widget
          ),
        ],
      )
    );
  }

  Widget _buildSwitch(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Switch(
          value: valor == 1,
          onChanged: (bool value) => setState(() => value ? valor = 1 : valor = 0),
          activeColor: Theme.of(context).primaryColor,
        );
      }
    );
  }

  String _getDescription(String identificador) {
    switch (identificador) {
      case "MOSTRAREVERTERPRODUZIRALTERACOES":
        return "Exibir botões de desfazer/refazer?";
      case "MOSTRANEGRITO":
        return "Exibir botão de negrito?";
      case "MOSTRAITALICO":
        return "Exibir botão de itálico?";
      case "MOSTRASUBLINHADO":
        return "Exibir botão de sublinhado?";
      case "MOSTRARISCADO":
        return "Exibir botão de riscado?";
      case "MOSTRAALINHAMENTOESQUERDA":
        return "Exibir botão alinhar à esquerda?";
      case "MOSTRAALINHAMENTOCENTRO":
        return "Exibir botão centralizar?";
      case "MOSTRAALINHAMENTODIREITA":
        return "Exibir botão alinhar à direita?";
      case "MOSTRAJUSTIFICADO":
        return "Exibir botão justificado?";
      case "MOSTRATABULACAODIREITA":
        return "Exibir botão aumentar recuo?";
      case "MOSTRATABULACAOESQUERDA":
        return "Exibir botão diminuir recuo?";
      case "MOSTRAESPACAMENTOLINHAS":
        return "Exibir opção de espaçamento entre linhas?";
      case "MOSTRACORLETRA":
        return "Exibir botão cor da fonte?";
      case "MOSTRACORFUNDOLETRA":
        return "Exibir botão cor de realce?";
      case "MOSTRALISTAPONTO":
        return "Exibir botão de lista?";
      case "MOSTRALISTANUMERICA":
        return "Exibir botão de lista numérica?";
      case "MOSTRALINK":
        return "Exibir botão de link?";
      case "MOSTRAFOTO":
        return "Exibir botão de foto?";
      case "MOSTRAAUDIO":
        return "Exibir botão de audio?";
      case "MOSTRAVIDEO":
        return "Exibir botão de vídeo?";
      case "MOSTRATABELA":
        return "Exibir botão de tabela?";
      case "MOSTRASEPARADOR":
        return "Exibir botão de separador?";
      case "AUTOSAVE":
        return "Salvar a anotação de forma automática?";
      case "MOSTRABOTAOCABECALHO":
        return "Exibir os botões de cabeçalho?";
      case "MOSTRALISTACHECK":
        return "Exibir botão de checklist?";
      case "MOSTRACODEBLOCK":
        return "Exibir botão de bloco em código? (Recomendado para desenvolvedores)";
      case "MOSTRAQUOTE":
        return "Exibir botão de citação?";
      case "MOSTRAINDENT":
        return "Exibir botão aumentar/diminuir recuo?";
      case "MOSTRACLEARFORMAT":
        return "Exibir botão de limpar formatação?";
      case "MOSTRAINLINECODE":
        return "Exibir botão de código em linha? (Recomendado para desenvolvedores)";
      case "MOSTRASMALLBUTTON":
        return "Exibir botão de fonte pequena?";
      case "MOSTRAFONTSIZE":
        return "Exibir opção de tamanho da fonte?";
      case "MOSTRAFONTFAMILY":
        return "Exibir opção de tipo da fonte?";
      case "MOSTRASEARCHBUTTON":
        return "Exibir botão de localizar?";
      case "MOSTRACAMERA":
        return "Exibir botão de câmera?";
      case "SHOWIMAGEAPP":
        return "Exibir as imagens padrão de fundo do aplicativo na anotação?";
    }

    return "";
  }

  List<dynamic> _getIconConfig(String identificador) {
    switch (identificador) {
      case "MOSTRAREVERTERPRODUZIRALTERACOES":
        return [Icons.undo, Icons.redo];
      case "MOSTRANEGRITO":
        return [Icons.format_bold];
      case "MOSTRAITALICO":
        return [Icons.format_italic];
      case "MOSTRASUBLINHADO":
        return [Icons.format_underlined];
      case "MOSTRARISCADO":
        return [Icons.format_strikethrough];
      case "MOSTRAALINHAMENTOESQUERDA":
        return [Icons.format_align_left];
      case "MOSTRAALINHAMENTOCENTRO":
        return [Icons.format_align_center];
      case "MOSTRAALINHAMENTODIREITA":
        return [Icons.format_align_right];
      case "MOSTRAJUSTIFICADO":
        return [Icons.format_align_justify];
      case "MOSTRATABULACAODIREITA":
        return [Icons.format_indent_increase_sharp];
      case "MOSTRATABULACAOESQUERDA":
        return [Icons.format_indent_decrease];
      case "MOSTRAESPACAMENTOLINHAS":
        return [const Text("1.0", style: TextStyle(fontWeight: FontWeight.bold))];
      case "MOSTRACORLETRA":
        return [Icons.format_color_text];
      case "MOSTRACORFUNDOLETRA":
        return [Icons.format_color_fill];
      case "MOSTRALISTAPONTO":
        return [Icons.list];
      case "MOSTRALISTANUMERICA":
        return [Icons.format_list_numbered];
      case "MOSTRALINK":
        return [Icons.link];
      case "MOSTRAFOTO":
        return [Icons.image_outlined];
      case "MOSTRAAUDIO":
        return [Icons.audiotrack_outlined];
      case "MOSTRAVIDEO":
        return [Icons.videocam_outlined];
      case "MOSTRATABELA":
        return [Icons.table_chart_outlined];
      case "MOSTRASEPARADOR":
        return [Icons.horizontal_rule];
      case "AUTOSAVE":
        return [Icons.save];
      case "MOSTRABOTAOCABECALHO":
        return [
          const Text("H1", style: TextStyle(fontWeight: FontWeight.bold)),
          const Text("H2", style: TextStyle(fontWeight: FontWeight.bold)),
          const Text("H3", style: TextStyle(fontWeight: FontWeight.bold))
        ];
      case "MOSTRALISTACHECK":
        return [Icons.check_box];
      case "MOSTRACODEBLOCK":
        return [Icons.code];
      case "MOSTRAQUOTE":
        return [Icons.format_quote_sharp];
      case "MOSTRAINDENT":
        return [
          Icons.format_indent_increase_sharp,
          Icons.format_indent_decrease
        ];
      case "MOSTRACLEARFORMAT":
        return [Icons.format_clear];
      case "MOSTRAINLINECODE":
        return [Icons.code];
      case "MOSTRASMALLBUTTON":
        return [Icons.format_size];
      case "MOSTRAFONTSIZE":
        return [
          _buildRichText("Tamanho", const Icon(Icons.arrow_drop_down_sharp)),
        ];
      case "MOSTRAFONTFAMILY":
        return [
          _buildRichText("Fonte", const Icon(Icons.arrow_drop_down_sharp))
        ];
      case "MOSTRASEARCHBUTTON":
        return [Icons.search];
      case "MOSTRACAMERA":
        return [Icons.camera_alt];
      case "SHOWIMAGEAPP":
        return [Icons.photo];
    }

    return [const SizedBox.shrink()];
  }

  Widget _buildRichText(String text, Icon icon) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
              color: Colors.black
            )
          ),
          WidgetSpan(
            child: icon,
            alignment: PlaceholderAlignment.middle
          )
        ]
      )
    );
  }
}