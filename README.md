# Climate and Statistical Analysis Scripts

Este repositório reúne scripts e notebooks desenvolvidos em análises climatológicas e estatísticas
associadas a diferentes artigos científicos publicados entre 2020 e 2025.  
O objetivo é disponibilizar métodos de análise de forma **aberta, reprodutível e didática**, 
seguindo os princípios **FAIR (Findable, Accessible, Interoperable, Reusable)**.

---

## 📂 Estrutura do repositório
- `rainfall_variability/` → análises de variabilidade pluviométrica
- `drought_vulnerability/` → construção de índices compostos sociais e climáticos
- `mann_kendall_trends/` → testes de tendência e homogeneidade (Mann-Kendall, Pettitt, SU, CDD)
- `coffee_risk_analysis/` → análise de risco climático em regiões cafeeiras
- `crop_water_content/` → correlação entre clima e conteúdo relativo de água em cafeeiros
- `climaterna_dataset/` → integração de dados de clima, saúde e poluição (BR-DWGD + séries temporais)
- `utils/` → funções gerais de leitura, limpeza e visualização

---

## ⚙️ Requisitos

### Python
- Python 3.10+  
- Bibliotecas:  
  ```bash
  pip install numpy pandas matplotlib seaborn scipy scikit-learn xarray netCDF4 geopandas rasterio
