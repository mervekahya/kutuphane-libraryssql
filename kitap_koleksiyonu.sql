PGDMP  (                    |            kitap_koleksiyonu    14.12    16.3     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16908    kitap_koleksiyonu    DATABASE     �   CREATE DATABASE kitap_koleksiyonu WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Turkish_T�rkiye.1254';
 !   DROP DATABASE kitap_koleksiyonu;
                postgres    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                postgres    false            �           0    0    SCHEMA public    ACL     Q   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   postgres    false    4            �            1259    16910    kitaplar    TABLE     �   CREATE TABLE public.kitaplar (
    id integer NOT NULL,
    yazar character varying(255) NOT NULL,
    baslik character varying(255) NOT NULL,
    tur character varying(100),
    yayin_yili integer
);
    DROP TABLE public.kitaplar;
       public         heap    postgres    false    4            �            1259    16909    kitaplar_id_seq    SEQUENCE     �   CREATE SEQUENCE public.kitaplar_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.kitaplar_id_seq;
       public          postgres    false    4    210            �           0    0    kitaplar_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.kitaplar_id_seq OWNED BY public.kitaplar.id;
          public          postgres    false    209            \           2604    16913    kitaplar id    DEFAULT     j   ALTER TABLE ONLY public.kitaplar ALTER COLUMN id SET DEFAULT nextval('public.kitaplar_id_seq'::regclass);
 :   ALTER TABLE public.kitaplar ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    210    209    210            �          0    16910    kitaplar 
   TABLE DATA           F   COPY public.kitaplar (id, yazar, baslik, tur, yayin_yili) FROM stdin;
    public          postgres    false    210   �       �           0    0    kitaplar_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.kitaplar_id_seq', 83, true);
          public          postgres    false    209            ^           2606    16917    kitaplar kitaplar_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.kitaplar
    ADD CONSTRAINT kitaplar_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.kitaplar DROP CONSTRAINT kitaplar_pkey;
       public            postgres    false    210            �   �  x��W�n�F]��> ėH.e[��j�����)�e��b��Hʡ~�� � ¬� @���;��5�d˔<L<���.�=��s/]r�`F򂞈Y�UA6d�N��E�"c5/�2#�4�̼"n&�G���Bq�r:aB��~�n��LMF�C�y�腱1O�*YQ���I�;>9��Q�~�wR���%2cjz�˒����˂�p:e������$rҟ�r��1��Ϝ|Tt$עN�䆜��q�O�����w����{�DKvK�;tҡ��8L/�:=2f�f��R��,2%�	)r:zF�����qm�~4w8�q@N�����-7qҗ��
:�~��yQzŕ�'̓±���]rZ�T���k�,2A&U�ͦ�W�|�9SH��s\�|R
�#c���3Áh.yI��f����u]�����TK�S��pX	Ն�"����G�Cm�y�W�d�M QQ/ �/�|!���dAG:�)�܊�>�*�!��u7$���W U���Tۮ7?3G�w�]�q�혁{ �d����-�;Ñͽ��?VB�|w'�w��B��8._p��%hj1��\�g���;j�ܷ����+=��Xz䳘�H}X�5�����u�s<��ż��-�,m�
r��T����^7t��/����y�G���)E�hy3gjN���L�r��$��p�C��ͽ�����"ˆ�N�`8d��$����D�7��J�/&Cn�H�\.-8d���-�-��&�J}I�d H�j��CN~�Kh�r��K��5=2Z�Ϳ��f]ɲ���[��}9���4�{�ќ�ǣ����Mv>�Ϧ�	P��yX�����p�
0��+��?��G�]�Kg��������G�Wۗ"�����^1�+������!�@��z�ɥ��tޝ�<�O^<d5HO��⦔b�~QP�N��ŋ�y�yt�j�|e
�C�E4߄�ΐK�M{���>��y@�8��%��M��j)j�Gz�>�4�p{6_;_(���Am�>���Lx,�|���"�z�6���	�[]��=�ʰM_P�fm[���d�r���[���6��~���,S���^K B��ؐ��H��ͽ���Vm&H9&��D"8L��͟���������ɾԇ�Tt`��P�ϛz�'��VVG�9�JN ���~"KT�2z%L.�"�rS��+�D]'t�GU���{�D�}���͵$@o�Ӷ�sB���p�wpŗ�]���$�h��@�8��Z�L�㈖
(�i't���0|+O�ݜ���M���������H�0�g��V���u��8t��e@��Jf
�'�{;�n�V��\Ţ5�ѵr5�KɸZ�ȋ�H�,���
��u�J0�UA�����-N g���g�B	�A�IBF֞�%:k�ǔ���?%�swZ�S�o��ܲ�>\[]g%t�b�P���yd�w�60WC���:PikiX��	�Mс���N���A���)0x��ڰ�6�H �<(����W^�+�x�+�y�(R�
�ؚ"�Տ쮻��mJ��1ĮӋ�E���DA'%_bv@�'�C�yVK����tX���=�I�>�%�"'�8��=��e.S��O�Cͳ*�c|��u�f�l2B]s��3�b�@C(�\|9��>r�#v������Fꂣ��{ �$���#��Y����'�G� �C�'���n����HSx2>9��L�R�����Y���(|s�� ��v%�BX��6�o���+6#gڀ'���K|���9g��(h�&ß�S�)ŏ�(&�T�����YQ�楝f��ۊ�N�`�<��l�ys���?r�.J�LH��Y�����2~=Ǘb�q������6�	C��g�n3^/���Fb�L�R|N�ݦ@�v,���.�7��Mf�3ώ+�k��ak�%�U��q�:F���q�Q<!�     