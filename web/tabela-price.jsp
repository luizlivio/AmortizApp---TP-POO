<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="WEB-INF/jspf/bootstrap-head.jspf" %>
        <title>AmortizApp - Tabela Price</title>
        <style>
            tr {
                text-align: center;
            }
        </style>
    </head>
    <body>
        <div>
            <%@include file="WEB-INF/jspf/navbar.jspf" %>
            <%@include file="WEB-INF/jspf/form.jspf" %>
            <%DecimalFormat formatador = new DecimalFormat("#.##");%>
             
            <% try{
                double valorParcela, valorJuros = 0, valorAmort = 0, acumParcela = 0, acumJuros = 0, acumAmort = 0;
                double valorDivida = Double.parseDouble(request.getParameter("valorDivida"));
                int qtdParcelas = Integer.parseInt(request.getParameter("qtdParcelas"));
                double juros = Double.parseDouble(request.getParameter("taxaJuros"));
                double taxa = juros / 100;
                valorParcela = valorDivida*((Math.pow((1+taxa), qtdParcelas)*taxa)/((Math.pow((1+taxa), qtdParcelas)-1)));
                
                if((valorDivida > 0) && (qtdParcelas > 0) && (taxa > 0)){%>
                    <table class="table">
                        <tr>
                            <th>Mês</th>
                            <th>Valor da Parcela</th>
                            <th>Valor dos Juros</th>
                            <th>Valor da Amortização</th>
                            <th>Saldo Devedor Total</th>
                        </tr>
                        <tr>
                            <td>0</td>
                            <td>-</td>
                            <td>-</td>
                            <td>-</td>
                            <td>R$ <%=valorDivida%></td>
                        </tr>
                        <%for (int i = 1; i <= qtdParcelas && valorDivida > 0; i++) { 
                            valorJuros = taxa*valorDivida;
                            valorAmort = valorParcela - valorJuros;
                            valorDivida -= valorAmort;
                            acumParcela += valorParcela;
                            acumJuros += valorJuros;
                            acumAmort += valorAmort;%>
                            <tr>
                                <td><%=i%></td>
                                <td>R$ <%=formatador.format(valorParcela)%></td>
                                <td>R$ <%=formatador.format(valorJuros)%></td>
                                <td>R$ <%=formatador.format(valorAmort)%></td>
                                <td>R$ <%=formatador.format(valorDivida)%></td>
                            </tr>
                        <%}%>
                        <tr style="font-weight: bold" >
                            <td>Total</td>
                            <td>R$ <%=formatador.format(acumParcela)%></td>
                            <td>R$ <%=formatador.format(acumJuros)%></td>
                            <td>R$ <%=formatador.format(acumAmort)%></td>
                            <td>-</td>
                        </tr>
                    </table> 
                <%} else{
                        out.println("Valor inválido ou não informado!");
                    }
            } catch(Exception ex) {;
            }%>
        </div>
        <%@include file="WEB-INF/jspf/bootstrap-scripts.jspf" %>
    </body>
</html>
